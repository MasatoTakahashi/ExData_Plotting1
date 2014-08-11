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


# plot 2
png("plot2.png")
plot(data2$DateTime, data2$Global_active_power, type="l", xaxt = "n"
     , xlab="", ylab="Global Active Power (kilowatts)")
axis.POSIXct(1, at = unique(round.POSIXt(data2$DateTime, "days")), format = "%a")
dev.off()


