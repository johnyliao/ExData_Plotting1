setwd('c:/dev/coursera')

data = read.table(file="household_power_consumption.txt",na.strings=c('?'),sep=";",header=T)

# Convert Date column to date data type
dates <- as.Date(data$Date, format="%d/%m/%Y")
doi <-  dates == as.Date("01/02/2007",format="%d/%m/%Y") | dates == as.Date("02/02/2007",format="%d/%m/%Y") 

activepower <- data$Global_active_power[doi]
submetering1 <- data$Sub_metering_1[doi]
submetering2 <- data$Sub_metering_2[doi]
submetering3 <- data$Sub_metering_3[doi]
voltage <- data$Voltage[doi]
reactivepower <- data$Global_reactive_power[doi]

dayofweek = weekdays(dates[doi])


tickpos = c(0,length(dayofweek[dayofweek=="Friday"]),length(dayofweek))
labels = c("Thu","Fri","Sat")

png(file="plot4.png",width=480,height=480,units="px",pointsize=12)
par(mfrow=c(2,2))

# Plot Global Active Power
plot(activepower,type='l',axes=F,xlab="", ylab="Global Active Power (kilowatts)")
axis(2)
axis(1,at=tickpos,labels=c("Thu","Fri","Sat"))
box()

# Plot voltage vs datetime
plot(voltage,type='l',axes=F,xlab="datetime", ylab="Voltage")
axis(2)
axis(1,at=tickpos,labels=c("Thu","Fri","Sat"))
box()

# Plot sub meterings
plot(submetering1,type='l',axes=F,xlab="", ylab="Energy sub metering")
points(submetering2,type='l',col='red')
points(submetering3,type='l',col='blue')
axis(2)
axis(1,at=tickpos,labels=c("Thu","Fri","Sat"))
box()
legend("topright",bty="n",lty=1,col=c("black","red","blue"),
     legend=c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "))

# Plot reactive power
plot(reactivepower,type='l',axes=F,xlab="datetime", ylab="Global_reactive_power")
axis(2)
axis(1,at=tickpos,labels=c("Thu","Fri","Sat"))
box()


#dev.copy(png,file="plot4.png")
dev.off()

