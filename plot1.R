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
dataSet$Time <- strptime(dataSet$Time, format = "%H:%M:%S")

# Make Plot 1
hist(dataSet$Global_active_power, main = "Global Active Power", col = "Red", xlab = "Global Active Power (kilowatts)")

#Save the file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()