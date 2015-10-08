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


# Make Plot 2
plot(dataSet$Global_active_power~dataSet$DateTime, type="l",  ylab="Global Active Power (kilowatts)", xlab="")

#Save the file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()