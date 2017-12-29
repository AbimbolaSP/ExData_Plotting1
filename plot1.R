##Source code for plotting plot1.pgn
##Code for reading household power consumption data into R

library(data.table)
require(data.table)

data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?", 
              stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, "%d/%m/%Y") ##Converting to date format

library(dplyr)         ##To use dplyr data manipulation tools
data = tbl_df(data)    ##converting data frame to a tibble
data <- mutate(data, Time = as.POSIXct(strptime(Time, "%H:%M:%S")))
datatoUse <- filter(data,Date == "2007-02-01"| Date == "2007/02/02") ##subsetting data
rm(data)  

##creating first plot in png file device

hist(datatoUse$Global_reactive_power, col = "red", 
     main = "Global Active Power", xlab = "Global active power (kilowatt)")
dev.copy(png, file = "plot1.png", width=480, height=480, units = "px")
dev.off()