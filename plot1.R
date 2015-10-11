#Reading the file from local directory
dataFile <- "household_power_consumption.txt"
maindata <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

# Formating the date
maindata$Date <- as.Date(maindata$Date, format="%d/%m/%Y")

#Selecting a subset of the data
dataset <- subset(maindata, maindata$Date >= "2007-02-01" & maindata$Date <= "2007-02-02")

# Generating the histogram and saving it as .png
gActPower <- as.numeric(dataset$Global_active_power)
png("plot1.png", width=480, height=480)
hist(gActPower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()