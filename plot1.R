#  plot1.R
## Globabl Active Power 01/02/2007 - 02/02/2007
## This script creates a chart and saves it to a file in the working directory
## The data corresponds to household global minute-averaged active power
## It reads data from the file household_power_consumption.txt
## If this file does not exists it will extract if from "exdata%2Fdata%2Fhousehold_power_consumption.zip"
## If the compressed file does not exist it will download household power consumption data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
plot1 <- function() {
  ## Plots a histogram of global active power for the inclusive data range 01/02/2007 - 02/02/2007 
  ##
  ## Args:
  ##   None
  ##
  ## Returns:
  ##   A 480x480 PNG file containing the graph saved in the working directory.
  ##
  if(!file.exists("household_power_consumption.txt")) {
    if(!file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, "exdata%2Fdata%2Fhousehold_power_consumption.zip")
    } 
    unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
  } 
  data<-read.table("household_power_consumption.txt", header = TRUE, sep=";", colClasses="character")
  subset1<-subset(data,Date=="1/2/2007")
  subset2<-subset(data,Date=="2/2/2007")
  subset<-rbind(subset1,subset2)
  Global_active_power <- as.numeric(subset$Global_active_power)
  png(filename="plot1.png", width = 480, height=480)
  hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
  invisible(dev.off())
}