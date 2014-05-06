setwd('c:/dev/coursera')

data = read.table(file="household_power_consumption.txt",na.strings=c('?'),sep=";",header=T)

# Convert Date column to date data type
dates <- as.Date(data$Date, format="%d/%m/%Y")

# Dates of interests
doi <-  dates == as.Date("01/02/2007",format="%d/%m/%Y") | dates == as.Date("02/02/2007",format="%d/%m/%Y") 

dayofweek <- weekdays(dates[doi])
activepower <- data$Global_active_power[doi]
submetering1 <- data$Sub_metering_1[doi]
submetering2 <- data$Sub_metering_2[doi]
submetering3 <- data$Sub_metering_3[doi]


tickpos = c(0,length(dayofweek[dayofweek=="Friday"]),length(dayofweek))
labels = c("Thu","Fri","Sat")


plot(submetering1,type='l',axes=F,xlab="", ylab="Energy sub metering")
points(submetering2,type='l',col='red')
points(submetering3,type='l',col='blue')
axis(2)
axis(1,at=tickpos,labels=c("Thu","Fri","Sat"))
box()
legend("topright",lty=1,col=c("black","red","blue"),
     legend=c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "))

dev.copy(png,file="plot3.png")
dev.off()
