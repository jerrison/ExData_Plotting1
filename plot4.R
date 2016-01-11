###############################################################################
# Author: Jerrison Li
# Date: 01.08.2016 5:24:35 PM 
# Description: 
#
###############################################################################

# library(downloader)
# download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
#     destfile = "Data/HHPC.zip")


library(dplyr)

# read in datafile from Data subdirectory
hhpc1 <- read.table("Data/household_power_consumption.txt", sep = ";", header =
                       TRUE, stringsAsFactors = FALSE)

# wrap data for easy viewing
hhpc <- tbl_df(hhpc1)

# filtering on days of interest
hhpc <- filter(hhpc, Date %in% c("2/2/2007", "1/2/2007"))

# create Date and Time combined variable "DateTime"
hhpc <- mutate(hhpc, DateTime = paste(Date, Time))

# convert it to datetime format
hhpc$DateTime <-  strptime(hhpc$DateTime, "%d/%m/%Y %H:%M:%S")

# launch png device
png(filename = "plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))

# (1, 1) plot
with(data = hhpc, plot(DateTime, as.numeric(Global_active_power), type = "l",
                       ylab = "Global Active Power (kilowatts)"))

# (2, 1) plot
with(data = hhpc, plot(DateTime, as.numeric(Sub_metering_1), type = "l",
    ylab = "Energy sub metering"))
with(data = hhpc, points(DateTime, as.numeric(Sub_metering_2), type = "l",
                       col = "red"))
with(data = hhpc, points(DateTime, as.numeric(Sub_metering_3), type = "l",
                         col = "blue"))
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# (1, 2) plot
with(data = hhpc, plot(DateTime, as.numeric(Voltage), type = "l",
                       xlab = "datetime",
                       ylab = "Voltage"))

# (1, 2) plot
with(data = hhpc, plot(DateTime, as.numeric(Global_reactive_power), type = "l",
                       xlab = "datetime",
                       ylab = "Global_reactive_power"))

# close png file
dev.off()


