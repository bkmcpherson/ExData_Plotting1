library("data.table")
df <- data.table::fread("household_power_consumption.txt", na.strings = "?") #read data into df variable
library("lubridate")
df$Date <- lubridate::dmy(df$Date) #convert "Date" column to date class
df <- subset(df, df$Date == "2007-02-01" | df$Date == "2007-02-02") #Subset data for specified dates

png("plot1.png", width = 480, height = 480) #Initialize png graphic device with height/width of 480 pixels
hist(df$Global_active_power, col = "red", breaks = 12, main = "Global Active Power", xlab = "Global Active Power (kilowatts)") #create histogram
dev.off()
