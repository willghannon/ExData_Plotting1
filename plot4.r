plot4<-function() {
  
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
  
  ## Set the class of the Global_active_power column to class numeric
  sub$Global_active_power <- as.numeric(sub$Global_active_power)
  
  ## open a PNG graphics device
  ## On the open device, plot a 2x2 graphical matrix containing plots from plot2 and plot3
  ## Additionally, add 2 new plots containing 'Global_reactive_power' vs. 'DateTime'
  ## And 'Voltage' vs. 'DateTime'.
  png(file = "plot4.png")  
  par(mfrow=c(2,2))
  
  plot(sub$DateTime, sub$Global_active_power, xlab = "", ylab = "Global Active Power", pch = "")
  lines(sub$DateTime, sub$Global_active_power)
  
  plot(sub$DateTime, sub$Voltage, pch = "", xlab = "datetime", ylab = "Voltage")
  lines(sub$DateTime, sub$Voltage)
  
  plot(sub$DateTime, sub$Sub_metering_1, xlab = "", ylab = "Energy sub metering", pch = "")
  lines(sub$DateTime, sub$Sub_metering_1)
  lines(sub$DateTime, sub$Sub_metering_2, col = "red")
  lines(sub$DateTime, sub$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")
  
  plot(sub$DateTime, as.numeric(sub$Global_reactive_power), pch = "", xlab = "datetime", ylab = "Global_reactive_power")
  lines(sub$DateTime, as.numeric(sub$Global_reactive_power))
  
  ## Close the open device
  dev.off()
  
  print("plot4.png has been printed to your working directory.")
}