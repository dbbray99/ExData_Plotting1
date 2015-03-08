plot1 <- function() {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile ="hpc.zip", method = "curl")
        unzip("hpc.zip","household_power_consumption.txt", exdir="./")
        initial <- read.table("household_power_consumption.txt", nrows=100, sep=";", na.strings="?", header = TRUE)
        classes <- sapply(initial, class)
        header <- read.table("household_power_consumption.txt", nrows=1, sep=";", header=FALSE, stringsAsFactors=FALSE)
        hpcData <- read.table("household_power_consumption.txt", colClasses=classes, sep=";", na.strings="?", header = FALSE, skip=66636, nrows=2880, stringsAsFactors=TRUE)
        colnames( hpcData ) <- unlist(header)
        png(file = "plot1.png", height=480, width=480)
        hist(hpcData$Global_active, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col="red")
        dev.off()
}