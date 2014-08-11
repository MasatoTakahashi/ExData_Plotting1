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

# plot 3
png("plot3.png")
plot(data2$DateTime, data2$Sub_metering_1, type = "l", xaxt = "n"
     , xlab="", ylab="Energy sub metering")
axis.POSIXct(1, at = unique(round.POSIXt(data2$DateTime, "days")), format = "%a")
lines(data2$DateTime, data2$Sub_metering_2, col = "red")
lines(data2$DateTime, data2$Sub_metering_3, col = "blue")
legend("topright"
       , legend = paste("Sub_metering_", 1:3, sep="")
       , lty = 1
       , col = c(1,2,4))
dev.off()


