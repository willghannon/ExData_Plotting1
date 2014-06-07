plot2<-function() {

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

## Set the class of column Global_active_power to numeric
sub$Global_active_power <- as.numeric(sub$Global_active_power)

## open a PNG graphics device and plot 'DateTime' vs. 'Global_active_power' onto the open device
png(file = "plot2.png")  
plot(sub$DateTime, sub$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", pch = "") 
lines(sub$DateTime, sub$Global_active_power)

## Close the device after plotting
dev.off()

print("plot2.png has been printed to your working directory.")
}