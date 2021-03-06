# UCI Machine Learning Repository
# http://archive.ics.uci.edu/ml/index.php
# “Individual household electric power consumption Data Set”

####### PREPARING THE DATA ########

# Loading Libraries
library(dplyr)
library(lubridate)

# Reading Data Frame
data = read.table("household_power_consumption.txt", sep=";", header = TRUE, dec = ".",na.strings = "?")

# Converting Dates as Date format.
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

# Subsetting the dataframe to the dates we need, and formatting columns to the right format. 
electric_df <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
electric_df[, 3:9] <- sapply(electric_df[, 3:9], function(x) as.numeric(as.character(x)))
electric_df$Fulldate <- paste(electric_df$Date, " ", electric_df$Time)
electric_df$Fulldate <- as_datetime(electric_df$Fulldate)
electric_df <- electric_df[,c(1,10,2,3,4,5,6,7,8,9)]

# Setting DataFrame as Tibble 
electric_df<-as_tibble(electric_df)

####### PLOT 2 ########
png("plot2.png", width = 480, height = 480)
with(electric_df, plot(electric_df$Fulldate, electric_df$Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)"))
dev.off()
