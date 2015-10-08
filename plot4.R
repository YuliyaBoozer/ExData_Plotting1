#install package if does not exist
if("sqldf" %in% rownames(installed.packages()) == FALSE) 
{
  install.packages("sqldf")
}

#load subset of needed data

library(sqldf)

dataSet <- read.csv.sql("household_power_consumption.txt",sql = 'select * from file where Date in("1/2/2007","2/2/2007") ', sep = ";")
closeAllConnections()

#Set proper data types
dataSet$Date <- as.Date(dataSet$Date, format="%d/%m/%Y")
DateTime <- paste(as.Date(dataSet$Date), dataSet$Time)
dataSet$DateTime <- as.POSIXct(DateTime)


# Make Plot 4
par(mfrow = c(2,2), mar = c(4,5,2,1), oma = c(3,1,0,0), cex = 0.7)

plot(dataSet$Global_active_power~dataSet$DateTime, type="l",  ylab="Global Active Power", xlab="")

plot(dataSet$Voltage~dataSet$DateTime, type="l",  ylab="Voltage", xlab="datetime")

with (dataSet, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(dataSet, lines(DateTime, Sub_metering_1, col = "Black"))
with(dataSet, lines(DateTime, Sub_metering_2, col = "Red"))
with(dataSet, lines(DateTime, Sub_metering_3, col = "Blue"))
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dataSet$Global_reactive_power~dataSet$DateTime, type="l",  ylab="Global_reactive_power", xlab="datetime")

#Save the file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()