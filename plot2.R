# Sequence to fulfil the requirements for Exploratory Data Analysis - Project 1
# My approach is not to load complete file but to only load the rows that
# required

# Note: The data file is to be loaded in the same directory as the script
# Date is included in column 1 of the 9 columns

# General approach is that each file could be run independently 
# of course if data has already been loaded and processed 
# these steps would not be need to be done for each plot

date_col <- rep("NULL", 9)      # date_col variable to capture only date column
date_col[1] <- "character"

Headers <- read.table("household_power_consumption.txt", header = TRUE, 
                      na.strings="?", row.names= NULL,  sep=";", nrows=1)
# read first row to get headings

raw_data_dates <-  read.table("household_power_consumption.txt", header = TRUE, 
                              na.strings="?", row.names= NULL,  sep=";", 
                              colClasses = date_col) #load the date column only

raw_data_dates$Date <-  strptime(raw_data_dates$Date, format="%d/%m/%Y")
# convert to dates

raw_data_rows <- which((raw_data_dates$Date == "2007-02-01")
                       |(raw_data_dates$Date == "2007-02-02"))
# get the rows where the date is in range

# This section sets the number of rows to skip in the data set to get to
# the date required.  From interagation of the data set the dates as sequential
# so no check has been made to confirm the rows are indeed sequential

skip_rows <- raw_data_rows[1]-1  # set the number of rows to skip
num_rows <- length(raw_data_rows) # set the number of rows to import

raw_data <-  read.table("household_power_consumption.txt", header = TRUE, 
                        na.strings="?", row.names= NULL,  sep=";", 
                        skip = skip_rows, nrows = num_rows) 
#load the date set

names(raw_data) <- names(Headers) # set the names in the data set

raw_data$Time <-paste(raw_data$Date, raw_data$Time)  # add the date to the time

raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")
# convert to dates

raw_data$Time <- strptime(raw_data$Time, format="%d/%m/%Y %H:%M:%S")
# convert time use POSIXlt so axis in plots all good


png(file ="plot2.png", width = 480, height = 480)    #open plot file

plot(raw_data$Time,raw_data$Global_active_power,type ="l",   #set line graph
     xlab="",                                            #clear x label default
     ylab = "Global Active Power (kilowatts)")           #set y label


dev.off()    #close the plot device