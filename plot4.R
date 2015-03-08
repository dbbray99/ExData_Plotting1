plot4 <- function() {
## Assignment 1 plot 4
        # Get file and unzip
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile ="hpc.zip", method = "curl")
        unzip("hpc.zip","household_power_consumption.txt", exdir="./")
        # Determine Column class using small sample
        initial <- read.table("household_power_consumption.txt", nrows=100, sep=";", na.strings="?", header = TRUE)
        classes <- sapply(initial, class)
        # Grab header - this is done because of skip in read.table
        header <- read.table("household_power_consumption.txt", nrows=1, sep=";", header=FALSE, stringsAsFactors=FALSE)
        # Skip used to move to file location where data range starts. two days = 2880 rows (2 days * 24 hr * 60 min = 2,880)
        # Not what I would typically do, but the exercise was to create the plot charts
        hpcData <- read.table("household_power_consumption.txt", colClasses=classes, sep=";", na.strings="?", header = FALSE, skip=66637, nrows=2880, stringsAsFactors=TRUE)
        # combine header and data
        colnames( hpcData ) <- unlist(header)
        # Tidy data for analyis
        hpcData$Date <- strptime(hpcData$Date, format="%e/%m/%Y") # format loaded date
        hpcData$compDay <- paste(hpcData$Date,hpcData$Time) # add combined Date and Time
        hpcData$compDay <- as.POSIXct(hpcData$compDay) # format combined date and time so Day can be determined            
        # Establish output device (png format)
        png(file = "plot4.png", height=480, width=480)
        # Create Plots
        par(mfrow=c(2,2))
        plot(hpcData$compDay, hpcData$Global_active, ylab="Global Active Power", xlab="", type='l')
        plot(hpcData$compDay, hpcData$Voltage, ylab="Voltage", xlab="datetime", type="l")
        plot(hpcData$compDay, hpcData$Sub_metering_3, ylab="Engery sub metering", xlab="", type="l", col="blue")
        legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5))
        plot(hpcData$compDay, hpcData$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
        # Close ouput device
        dev.off()
}