# Download and read the data into the dataframe powerdataframe
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
con <- unzip(temp)
powerdataframe <- data.frame(read.table(con, header = TRUE, sep = ";"))
unlink(temp)

# Convert Data and Time variables to date format
powerdataframe$Date <- as.Date(powerdataframe$Date, format = "%d/%m/%Y")
powerdataframe$Time <- format(strptime(powerdataframe$Time, format = "%H:%M:%S"), "%H:%M:%S")

# Subset powerdataframe to obtain the dataset with global active power, voltage, sub meterings, global reactive power, date, and time
modifiedpowerdataframe <- subset(powerdataframe, Date == "2007-02-01" | Date == "2007-02-02", select = c("Global_active_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Global_reactive_power", "Date", "Time"))
modifiedpowerdataframe$Global_active_power <- as.numeric(unlist(modifiedpowerdataframe$Global_active_power))
modifiedpowerdataframe$Global_reactive_power <- as.numeric(unlist(modifiedpowerdataframe$Global_reactive_power))
modifiedpowerdataframe$Sub_metering_1 <- as.numeric(unlist(modifiedpowerdataframe$Sub_metering_1))
modifiedpowerdataframe$Sub_metering_2 <- as.numeric(unlist(modifiedpowerdataframe$Sub_metering_2))
modifiedpowerdataframe$Sub_metering_3 <- as.numeric(unlist(modifiedpowerdataframe$Sub_metering_3))

# Create DateTime variable from Date and Time variables
modifiedpowerdataframe$DateTime <- as.POSIXct(paste(modifiedpowerdataframe$Date, modifiedpowerdataframe$Time), format="%Y-%m-%d %H:%M:%S")

# Create the plots
png("plot4.png", height = 480, width = 480)
par(mfrow = c(2, 2))
plot(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")
plot(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")
plot(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Sub_metering_1, type = "l",
     col = "black", xlab = "", ylab = "Energy sub metering")
lines(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Sub_metering_2, type = "l",
      col = "red")
lines(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Sub_metering_3, type = "l",
      col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = c(1, 1, 1), box.lty = 0)
plot(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

