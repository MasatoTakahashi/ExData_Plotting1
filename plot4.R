# requirement: 
# the data "household_power_consumption.txt" should be unzpipped and placed in the same 
# directory as this source code
# the working directory should be the same where this source code is saved


# read the raw data
# once, read the 1st and 2nd columns as character
# the character "?" is revalued as NA
data <- read.csv("household_power_consumption.txt", sep=";"
                 , colClasses=c(rep("character", 2), rep("numeric", 7) )
                 , na.strings ="?")

# convert 1st and 2nd column into one datetime type
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %T")

# extract the estimated records and store it in new variable
data2 <- data[which(data$DateTime >= as.POSIXlt("2007/02/01") & data$DateTime < as.POSIXlt("2007/02/03")), ]


# plot 4
png("plot4.png")
# split layout
layout(matrix(1:4, ncol=2))
# top right
plot(data2$DateTime, data2$Global_active_power, type="l"
     , xlab="", ylab="Global Active Power")
# bottom right
plot(data2$DateTime, data2$Sub_metering_1, type = "l"
     , xlab="", ylab="Energy sub metering")
lines(data2$DateTime, data2$Sub_metering_2, col = "red")
lines(data2$DateTime, data2$Sub_metering_3, col = "blue")
legend("topright", box.lwd = 0, bg = NULL
       , legend = paste("Sub_metering_", 1:3, sep="")
       , lty = 1
       , col = c(1,2,4))
# top left
plot(data2$DateTime, data2$Voltage, type="l"
     , xlab="datetime", ylab="Voltage")
# bottom left
plot(data2$DateTime, data2$Global_reactive_power, type="l"
     , xlab="datetime", ylab="Global_reactive_power")
dev.off()


