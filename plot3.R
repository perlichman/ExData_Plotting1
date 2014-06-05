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

### Builds Plot 3
png( filename = "plot3.png", width = 480, height = 480, units = "px", bg = "#ffffff" )

plot( data$DateTime, 
      data$Sub_metering_1, 
      type = "n",
      xlab = "", 
      ylab = "Energy sub metering" 
)

## Create lines
lines( data$DateTime, data$Sub_metering_1, col = "black" )
lines( data$DateTime, data$Sub_metering_2, col = "red" )
lines( data$DateTime, data$Sub_metering_3, col = "blue" )

## Create legend
legend(
  "topright", 
  c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), 
  lty = c( 1, 1, 1 ), 
  lwd = c( 2, 2, 2 ),
  col = c( "black", "red", "blue" )
)
dev.off()