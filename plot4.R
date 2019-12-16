df <- data.table::fread("household_power_consumption.txt", na.strings = "?") #read data into df variable
library("lubridate")
df$Date <- lubridate::dmy(df$Date) #convert "Date" column to date class
df <- subset(df, df$Date == "2007-02-01" | df$Date == "2007-02-02") #Subset data for specified dates
df[, dateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")] #create new column with date & time combined

png("plot4.png", width = 480, height = 480) #Initialize png graphic device with height/width of 480 pixels
par(mfrow = c(2,2)) #2x2 graph layout
plot(df$Global_active_power ~ df$dateTime, type = "l", ylab = "Global Active Power")
plot(df$Voltage ~ df$dateTime, type = "l", ylab = "Voltage", xlab = "datetime")
plot(df$Sub_metering_1 ~ df$dateTime, type = "l", ylab = "Energy sub metering", xlab = "") #create plot area without showing points
lines(df$Sub_metering_1 ~ df$dateTime) #create lines connecting points
lines(df$Sub_metering_2 ~ df$dateTime, col = "red")
lines(df$Sub_metering_3 ~ df$dateTime, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty = "n", lty = c(1,1), lwd = c(1,1))
plot(df$Global_reactive_power ~ df$dateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off() #close graphic device