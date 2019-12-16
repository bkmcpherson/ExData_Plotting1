library("data.table")
df <- data.table::fread("household_power_consumption.txt", na.strings = "?") #read data into df variable
library("lubridate")
df$Date <- lubridate::dmy(df$Date) #convert "Date" column to date class
df <- subset(df, df$Date == "2007-02-01" | df$Date == "2007-02-02") #Subset data for specified dates
df[, dateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")] #create new column with date & time combined

png("plot2.png", width = 480, height = 480) #Initialize png graphic device with height/width of 480 pixels
plot(df$Global_active_power ~ df$dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "") #create plot using lines
dev.off() #close graphic device
