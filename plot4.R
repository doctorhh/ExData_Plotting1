#Reading the file from local directory
dataFile <- "household_power_consumption.txt"
maindata <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
# Formating the date
maindata$Date <- as.Date(maindata$Date, format="%d/%m/%Y")

#Selecting a subset of the data
dataset <- subset(maindata, maindata$Date >= "2007-02-01" & maindata$Date <= "2007-02-02")
datetime <- paste(as.Date(dataset$Date), dataset$Time)
dataset$Datetime <- as.POSIXct(datetime)

#Plotting the graph in a 2 x 2 setup with predefined margin to allow label to show
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1))
#Due to the above date conversion in POSIXct format the utilisation of with(data,...) was necessary
with(dataset, {
      plot(Global_active_power~Datetime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      plot(Voltage~Datetime, type="l", 
           ylab="Voltage (volt)", xlab="")
      plot(Sub_metering_1~Datetime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~Datetime,col='Red')
      lines(Sub_metering_3~Datetime,col='Blue')
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Global_reactive_power~Datetime, type="l", 
           ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()