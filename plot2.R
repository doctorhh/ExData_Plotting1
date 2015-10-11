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

#Ploting the graph
gActPower <- as.numeric(dataset$Global_active_power)
png("plot2.png", width=480, height=480)
plot(dataset$Datetime, gActPower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()