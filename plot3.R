#Reading the file from local directory
dataFile <- "household_power_consumption.txt"
maindata <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
# Formating the date
maindata$Date <- as.Date(maindata$Date, format="%d/%m/%Y")

#Selecting a subset of the data
dataset <- subset(maindata, maindata$Date >= "2007-02-01" & maindata$Date <= "2007-02-02")
#Since a first conversion has been applied on date strptime() could not be re-used. Hence the
#the utilisation of as.POSIXct to convert the date and time
datetime <- paste(as.Date(dataset$Date), dataset$Time)
dataset$Datetime <- as.POSIXct(datetime)

#Plotting the graph with the legend
png("plot3.png", width=480, height=480)
#Due to the above date conversion in POSIXct format the utilisation of with(data,...) was necessary
with(dataset,{
     plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~Datetime,col='Red')
     lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
