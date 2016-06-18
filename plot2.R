options(warn=-1) #if the script fails make sure you type options(warn=0) in the console.
library(data.table)
dataFile <- "household_power_consumption.txt" # the name of the file do load in the working directory
data <- fread(dataFile, sep=";", stringsAsFactors = FALSE, header = TRUE) # using fread for faster reading of large file
beginEndDates <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]  # subset the data

# get the data for the plot
datetime <- strptime(paste(beginEndDates$Date, beginEndDates$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
activePower <- as.numeric(beginEndDates$Global_active_power)

# create the plot shell
png("plot2.png", width=480, height=480)

# plot the data
plot(datetime, activePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
options(warn=0)