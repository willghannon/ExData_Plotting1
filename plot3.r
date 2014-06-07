plot3<-function() {
  
  ## Download file from link provided in assignment
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  st <- read.csv2(unz(temp, "household_power_consumption.txt"), stringsAsFactors = FALSE)
  unlink(temp)
  
  ## Create a new column with continuous time keeping in POSIXct class
  st$DateTime <- paste(st$Date, st$Time)  
  st$DateTime <- strptime(st$DateTime, format = "%d/%m/%Y %H:%M:%S")
  
  ## Set Date column to class 'Date' to prepare for subsetting data
  st$Date<-as.Date(st$Date, format = "%d/%m/%Y")
  
  ## Subset the data according to the instructions in the assignment
  sub<-subset(st,st$Date == "2007-02-01" | st$Date == "2007-02-02")
  
  ## open a PNG graphics device and plot 'Sub_metering_1', 'Sub_metering_2', and 'Sub_metering_3' onto the open device
  png(file = "plot3.png")  
  plot(sub$DateTime, sub$Sub_metering_1, xlab = "", ylab = "Energy sub metering", pch = "")
  
  ## Set the line colors of the plot to black, red, and blue
  lines(sub$DateTime, sub$Sub_metering_1)
  lines(sub$DateTime, sub$Sub_metering_2, col = "red")
  lines(sub$DateTime, sub$Sub_metering_3, col = "blue")
  
  ## Add a legend including all lines and colors along with the variable being plotted into the upper right hand corner
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))
  
  ## Close the device after plotting
  dev.off()
  
  print("plot3.png has been printed to your working directory.")
}