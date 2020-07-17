# Download and read the data into the dataframe powerdataframe
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
con <- unzip(temp)
powerdataframe <- data.frame(read.table(con, header = TRUE, sep = ";"))
unlink(temp)

# Convert Data and Time variables to date format
powerdataframe$Date <- as.Date(powerdataframe$Date, format = "%d/%m/%Y")
powerdataframe$Time <- format(strptime(powerdataframe$Time, format = "%H:%M:%S"), "%H:%M:%S")

# Subset powerdataframe to obtain the dataset with sub meterings, date, and time
modifiedpowerdataframe <- subset(powerdataframe, Date == "2007-02-01" | Date == "2007-02-02", select = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Date", "Time"))
modifiedpowerdataframe$Sub_metering_1 <- as.numeric(unlist(modifiedpowerdataframe$Sub_metering_1))
modifiedpowerdataframe$Sub_metering_2 <- as.numeric(unlist(modifiedpowerdataframe$Sub_metering_2))
modifiedpowerdataframe$Sub_metering_3 <- as.numeric(unlist(modifiedpowerdataframe$Sub_metering_3))

# Create DateTime variable from Date and Time variables
modifiedpowerdataframe$DateTime <- as.POSIXct(paste(modifiedpowerdataframe$Date, modifiedpowerdataframe$Time), format="%Y-%m-%d %H:%M:%S")

# Create the plot
png("plot3.png", height = 480, width = 480)
plot(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Sub_metering_1,
     ylab = "Energy sub metering", xlab = "", col = "black", type = "l")
lines(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Sub_metering_2,
      col = "red")
lines(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Sub_metering_3,
      col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = c(1, 1, 1))
dev.off()
