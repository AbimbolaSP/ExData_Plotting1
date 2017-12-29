##Source code for plotting plot3.pgn
##Code for reading household power consumption data into R

library(data.table)
require(data.table)

data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?", 
              stringsAsFactors = FALSE)
data$datetime <- as.POSIXct(paste(data$Date,data$Time),  format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
library(dplyr)         ##To use dplyr data manipulation tools
data = tbl_df(data)    ##converting data frame to a tibble
datatoUse <- filter(data,Date == "2007-02-01"| Date == "2007/02/02") ##subsetting data
rm(data)  


##creating third plot in png file device

with(datatoUse, plot(datetime, Sub_metering_1, type ="l", ylab="Energy sub metering", xlab = ""))
with(datatoUse, points(datetime, Sub_metering_2, type ="l", col = "red"))
with(datatoUse, points(datetime, Sub_metering_3, type ="l", col = "blue"))
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty= 1)

dev.copy(png, file = "plot3.png", width=480, height=480, units = "px")
dev.off()