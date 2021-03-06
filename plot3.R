## Assignment for Exploratory Data Analysis
# plot3.R -- coded & commented by h-rm_tan 07Nov2015

## NOTES:
# http://archive.ics.uci.edu/ml/
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip      
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

####

## --- LIBRARIES --------------------------------------------------------------
library(graphics)
library(lubridate)
library(dplyr)

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
# ## PLOT 3 -- Multiple-TIMESERIES -- EnergySubMetering over time/days

# Add Column of Days to data
D2007feb <- mutate(D2007feb, "Day" = wday(D2007feb$Date, label = TRUE))

# Find Index of Start of a New Day
dayStartIdx <- which(D2007feb$Time=="00:00:00")   # [1]    1 1441

## set PNG Graphics
png(file = "plot3.png", bg = "white", width=480, height=480)

## create Multiple-TIMESERIES plots
with(D2007feb, ts.plot(ts(Sub_metering_1), ts(Sub_metering_2), ts(Sub_metering_3), gpars = list(col = c("black", "red", "blue"), xlab="", ylab="Energy sub metering", axes=FALSE) ) ) # don't plot the axes yet

# plot the y axis 1st
axis(2) 
# plot the x axis next with specifications of x-labelling
axis(1, labels = c(as.character(D2007feb$Day[dayStartIdx] ), "Sat"), 
     at=c( dayStartIdx, length(D2007feb$Time)+1 ) ) 

legend("topright", pch=c('','',''), lty = c(1,1,1), col=c("black","red","blue"), legend=names(D2007feb)[7:9]) #, xjust = 1) #, box.col ="transparent")
box() # add box around  plot

## PRINT
# dev.print(png, file="plot3.png", width=480, height=480, bg="white")
dev.off()
