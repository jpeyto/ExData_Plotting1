#  plot3.R
## Energy Sub Metering 01/02/2017 - 02/02/2007
## This script creates a chart and saves it to a file in the working directory
## The data is for energy sub metering which corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
## It reads data from the file household_power_consumption.txt
## If this file does not exists it will extract if from "exdata%2Fdata%2Fhousehold_power_consumption.zip"
## If the compressed file does not exist it will download household power consumption data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
plot3 <- function() {
  ## Plots energy sub metering for the inclusive data range 01/02/2007 - 02/02/2017 
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
  dates<-as.POSIXct(paste(subset$Date,subdata3$Time,sep=" "),format="%d/%m/%Y%H:%M:%S", tz="GMT")
  Sub_metering_1 <- as.numeric(subset$Sub_metering_1)
  Sub_metering_2 <- as.numeric(subset$Sub_metering_2)
  Sub_metering_3 <- as.numeric(subset$Sub_metering_3)
  png(filename="plot3.png", width = 480, height=480)
  plot(dates,Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab="")
  lines(dates,Sub_metering_2, type="l", col="red")
  lines(dates,Sub_metering_3, type="l", col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
  invisible(dev.off())
}