# Download and read the data into the dataframe powerdataframe
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
con <- unzip(temp)
powerdataframe <- data.frame(read.table(con, header = TRUE, sep = ";"))
unlink(temp)

# Convert Data and Time variables to date format
powerdataframe$Date <- as.Date(powerdataframe$Date, format = "%d/%m/%Y")
powerdataframe$Time <- format(strptime(powerdataframe$Time, format = "%H:%M:%S"), "%H:%M:%S")

# Subset powerdataframe to dates 2007-02-01 and 2007-02-02 and convert it to numeric vector
modifiedpowerdataframe <- subset(powerdataframe, Date == "2007-02-01" | Date == "2007-02-02", select = c(Global_active_power))
modifiedpowerdataframe <- as.numeric(unlist(modifiedpowerdataframe))

# Plot the histogram and save it plot1.png
png("plot1.png", height = 480, width = 480)
hist(modifiedpowerdataframe, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", breaks = 12, col = "red", ylim = c(0, 1200))
dev.off()
