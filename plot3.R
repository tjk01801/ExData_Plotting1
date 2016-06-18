options(warn=-1) #if the script fails make sure you type options(warn=0) in the console.
library(data.table)
dataFile <- "household_power_consumption.txt" # the name of the file do load in the working directory
data <- fread(dataFile, sep=";", stringsAsFactors = FALSE, header = TRUE) # using fread for faster reading of large file
beginEndDates <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]  # subset the data


datetime <- strptime(paste(beginEndDates$Date, beginEndDates$Time, sep=" "), "%d/%m/%Y %H:%M:%S") # convert variables to class "POSIXlt"

# convert the next four values to a numeric class and store the data for the plot
sub1 <- as.numeric(beginEndDates$Sub_metering_1)
sub2 <- as.numeric(beginEndDates$Sub_metering_2)
sub3 <- as.numeric(beginEndDates$Sub_metering_3)

# create the plot shell
png("plot3.png", width=480, height=480)
plot(datetime, sub1, type="l", ylab="Energy Submetering", xlab="")

# annotate the plot
lines(datetime, sub2, type="l", col="red")
lines(datetime, sub3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()
options(warn=0)