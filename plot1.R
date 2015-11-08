## Assignment for Exploratory Data Analysis
# plot1.R -- coded & commented by h-rm_tan 07Nov2015

## NOTES:
# http://archive.ics.uci.edu/ml/
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip      
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

####

## --- LIBRARIES --------------------------------------------------------------
library(graphics)
library(lubridate)
# library(dplyr)

## --- SET PATHS --------------------------------------------------------------
# datapath <- "~/Documents/ownCloud/Coursera_DataScienceTrack_JH/04_ExploratoryDataAnalysis/"
# setwd(datapath)

## --- READ FILE --------------------------------------------------------------
## --- variables
Hpowcomp <- read.csv("household_power_consumption.txt", sep = ";", na.strings = c("NA", "?") )  
# dim(Hpowcomp)  # [1] 2075259 x 9

# names(Hpowcomp)
# # [1] "Date"                  "Time"                  "Global_active_power"  
# # [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
# # [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"       

# CONVERT DATE -- using lubridate package
Hpowcomp$Date <- dmy(Hpowcomp$Date)
# wday(Hpowcomp$Date, label = TRUE)

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
D2007feb <- subset(Hpowcomp, (Date=="2007-02-01" | Date=="2007-02-02") )


# ----------------------------------------------------------------------------------------------------
## PLOT 1 -- HISTOGRAM -- Global Active power

# dev.new()
## set PNG graphics
png(file = "plot1.png", bg = "white", width=480, height=480)

## create HISTOGRAM
with(D2007feb, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power") )

## PRINT
# dev.copy(png, file="plot1.png", width=480, height=480, bg="white")
dev.off()

