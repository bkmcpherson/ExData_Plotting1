library("data.table")
df <- data.table::fread("household_power_consumption.txt", na.strings = "?") #read data into df variable
library("lubridate")
df$Date <- lubridate::dmy(df$Date) #convert "Date" column to date class
df <- subset(df, df$Date == "2007-02-01" | df$Date == "2007-02-02") #Subset data for specified dates
df[, dateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")] #create new column with date & time combined

png("plot4.png", width = 480, height = 480) #Initialize png graphic device with height/width of 480 pixels
par(mfrow = c(2,2)) #2x2 graph layout
plot(df$Global_active_power ~ df$dateTime, type = "l", ylab = "Global Active Power") #create plot 1
plot(df$Voltage ~ df$dateTime, type = "l", ylab = "Voltage", xlab = "datetime") #create plot 2
plot(df$Sub_metering_1 ~ df$dateTime, type = "l", ylab = "Energy sub metering", xlab = "") #create plot 3
lines(df$Sub_metering_2 ~ df$dateTime, col = "red") #add submeter2 red lines to plot 3
lines(df$Sub_metering_3 ~ df$dateTime, col = "blue") #add submeter3 blue lines to plot 3
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty = "n", lty = c(1,1), lwd = c(1,1)) #add legend to plot 3
plot(df$Global_reactive_power ~ df$dateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime") #create plot 4

dev.off() #close graphic device
