#------------------------------------------------------------------------
# Coursera - Exploratory Data Analysis
# Course Project 1 - Plot 2
#-----------------------------------------------------------------------

setwd('c:/dev/coursera')

data = read.table(file="household_power_consumption.txt",na.strings=c('?'),sep=";",header=T)

# Convert Date column to date data type
dates <- as.Date(data$Date, format="%d/%m/%Y")


# Dates of interests
doi <-  dates == as.Date("01/02/2007",format="%d/%m/%Y") | dates == as.Date("02/02/2007",format="%d/%m/%Y") 

# Convert data to datetime format
toDateTime <- function(data) {
  as.POSIXct(strptime(data,format="%d/%m/%Y %H:%M:%S"))
}

# Combine Date & Time column to get datetime
datepart <- sapply(data$Date[doi],toString)
timepart <- sapply(data$Time[doi],toString)
datetimestr <- paste(datepart,timepart,sep=" ")
dt <- sapply(datetimestr,toDateTime)

# Get just the dates we want to work with
datadates <- dates[doi]

# Calculate tick position and labels
x<-dt[dt <  as.POSIXct(strptime("2007-02-02 00:00:00",format="%Y-%m-%d %H:%M:%S"))]

tickpos = c(dt[1],dt[length(x)+1],dt[length(dt)])
labels = c(weekdays(datadates[1],abbreviate=T),
           weekdays(datadates[length(dt)],abbreviate=T),
           weekdays(datadates[length(dt)]+1,abbreviate=T))


activepower <- data$Global_active_power[doi]


plot(dt,activepower,type='l',axes=F,xlab="", ylab="Global Active Power (kilowatts)")
axis(2)
axis(1,at=tickpos,labels=labels)
box()

dev.copy(png,file="plot2.png")
dev.off()
