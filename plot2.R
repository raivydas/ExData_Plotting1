# Download and read the data into the dataframe powerdataframe
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
con <- unzip(temp)
powerdataframe <- data.frame(read.table(con, header = TRUE, sep = ";"))
unlink(temp)

# Convert Data and Time variables to date format
powerdataframe$Date <- as.Date(powerdataframe$Date, format = "%d/%m/%Y")
powerdataframe$Time <- format(strptime(powerdataframe$Time, format = "%H:%M:%S"), "%H:%M:%S")

# Subset powerdataframe to obtain the dataset with global active power, date, and time
modifiedpowerdataframe <- subset(powerdataframe, Date == "2007-02-01" | Date == "2007-02-02", select = c("Global_active_power", "Date", "Time"))
modifiedpowerdataframe$Global_active_power <- as.numeric(unlist(modifiedpowerdataframe$Global_active_power))

# Create DateTime variable from Date and Time variables
modifiedpowerdataframe$DateTime <- as.POSIXct(paste(modifiedpowerdataframe$Date, modifiedpowerdataframe$Time), format="%Y-%m-%d %H:%M:%S")

# Create the plot
png("plot2.png", height = 480, width = 480)
plot(modifiedpowerdataframe$DateTime, modifiedpowerdataframe$Global_active_power,
     ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
dev.off()
