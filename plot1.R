setwd('c:/dev/coursera')

data = read.table(file="household_power_consumption.txt",na.strings=c('?'),sep=";",header=T)

# Convert Date column to date data type
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Dates of interest
doi <-  data$Date == as.Date("01/02/2007",format="%d/%m/%Y") | data$Date == as.Date("02/02/2007",format="%d/%m/%Y") 

# Plot histogram of Global Active Power
hist(data$Global_active_power[doi],col="red", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     main= "Global Active Power")

# Dump to png file
dev.copy(png,file="plot1.png")
dev.off()