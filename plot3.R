setwd('c:/dev/coursera')

data = read.table(file="household_power_consumption.txt",na.strings=c('?'),sep=";",header=T)

# Convert Date column to date data type
dates <- as.Date(data$Date, format="%d/%m/%Y")
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


# Get dependent plot data
submetering1 <- data$Sub_metering_1[doi]
submetering2 <- data$Sub_metering_2[doi]
submetering3 <- data$Sub_metering_3[doi]

plot(dt,submetering1,type='l',axes=F,xlab="", ylab="Energy sub metering")
points(dt,submetering2,type='l',col='red')
points(dt,submetering3,type='l',col='blue')
axis(2)
axis(1,at=tickpos,labels=labels)
box()
legend("topright",lty=1,col=c("black","red","blue"),
     legend=c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "))

dev.copy(png,file="plot3.png")
dev.off()
