##Source code for plotting plot2.pgn
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


##creating second plot in png file device

with(datatoUse, plot(datetime, Global_active_power, type="l",
                     ylab = "Global Active Power (Kilowatts)",
                     xlab = ""))

dev.copy(png, file = "plot2.png", width=480, height=480, units = "px")
dev.off()