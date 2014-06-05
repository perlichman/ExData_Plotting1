#finds file
filename <- "household_power_consumption.txt"
# Sets date range for the time need
data <- read.table(filename, header = TRUE, sep = ";")
data <- data[ data$Date %in% c( "1/2/2007", "2/2/2007" ), ]
#Makes sure correct data type is used
data$Global_active_power <- as.numeric( as.character( data$Global_active_power ) )
data$Global_reactive_power <- as.numeric( as.character( data$Global_reactive_power ) )
data$Voltage <- as.numeric( as.character( data$Voltage ) )
data$Sub_metering_1 <- as.numeric( as.character( data$Sub_metering_1 ) )
data$Sub_metering_2 <- as.numeric( as.character( data$Sub_metering_2 ) )
data$Sub_metering_3 <- as.numeric( as.character( data$Sub_metering_3 ) )

dataTime <- paste( data$Date, data$Time )
data$DateTime <- strptime( dataTime, format = "%d/%m/%Y %H:%M:%S" )

### Builds Plot 4
png( filename = "plot4.png", width = 480, height = 480, units = "px", bg = "#ffffff" )

par( mfrow = c( 2, 2 ) )

## Build top left - Global Active Power
plot( data$DateTime, 
      data$Global_active_power, 
      type = "l", 
      ylab = "Global Active Power", 
      xlab = "" )

## Build top right - Voltage
plot( data$DateTime, 
      data$Voltage, 
      type = "l", 
      ylab = "Voltage", 
      xlab = "datetime")

## Build bottom left - Sub metering
plot( data$DateTime, 
      data$Sub_metering_1, 
      type = "n",
      xlab = "", 
      ylab = "Energy Sub Metering")
##Create sub metering lines
lines( data$DateTime, data$Sub_metering_1, col = "black")
lines( data$DateTime, data$Sub_metering_2, col = "red")
lines( data$DateTime, data$Sub_metering_3, col = "blue")

##Create sub metering legend
legend( "topright", 
        c( "Sub_metering_1",
           "Sub_metering_2", 
           "Sub_metering_3"), 
        lty = c( 1, 1, 1 ), 
        lwd = c( 2, 2, 2 ), 
        col = c( "black", "red", "blue" ) )

## Build bottom right - Global reactive power
plot(data$DateTime, 
     data$Global_reactive_power, 
     type="l", 
     ylab="Global_reactive_power", 
     xlab="datetime"
)
dev.off()