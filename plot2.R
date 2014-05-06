setwd('c:/dev/coursera')

data = read.table(file="household_power_consumption.txt",na.strings=c('?'),sep=";",header=T)

# Convert Date column to date data type
dates <- as.Date(data$Date, format="%d/%m/%Y")

# Dates of interests
doi <-  dates == as.Date("01/02/2007",format="%d/%m/%Y") | dates == as.Date("02/02/2007",format="%d/%m/%Y") 

dayofweek <- weekdays(dates[doi])
activepower <- data$Global_active_power[doi]

# Set tick position for days of week
tickpos = c(0,length(dayofweek[dayofweek=="Friday"]),length(dayofweek))

# Hard code the labels 
labels = c("Thu","Fri","Sat")

plot(activepower,type='l',axes=F,xlab="", ylab="Global Active Power (kilowatts)")
axis(2)
axis(1,at=tickpos,labels=c("Thu","Fri","Sat"))
box()

dev.copy(png,file="plot2.png")
dev.off()
