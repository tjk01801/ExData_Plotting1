options(warn=-1) #if the script fails make sure you type options(warn=0) in the console.
library(data.table)
dataFile <- "household_power_consumption.txt" # the name of the file do load in the working directory
data <- fread(dataFile, sep=";", stringsAsFactors = FALSE, header = TRUE) # using fread for faster reading of large file
beginEndDates <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]  # subset the data

dateTime <- strptime(paste(beginEndDates$Date, beginEndDates$Time, sep=" "), "%d/%m/%Y %H:%M:%S") # convert variables to class "POSIXlt"

# gather the variables for the plots
activePower <- as.numeric(beginEndDates$Global_active_power)
reactivePower <- as.numeric(beginEndDates$Global_reactive_power)
voltage <- as.numeric(beginEndDates$Voltage)
sub1 <- as.numeric(beginEndDates$Sub_metering_1)
sub2 <- as.numeric(beginEndDates$Sub_metering_2)
sub3 <- as.numeric(beginEndDates$Sub_metering_3)

# create the plot shell
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

# fill in the data for the plot
plot(dateTime, activePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(dateTime, voltage, type="l", xlab="dateTime", ylab="Voltage")
plot(dateTime, sub1, type="l", ylab="Energy Submetering", xlab="")

# annotate the plot
lines(dateTime, sub2, type="l", col="red")
lines(dateTime, sub3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(dateTime, reactivePower, type="l", xlab="dateTime", ylab="Global_reactive_power")

dev.off()
options(warn=0)