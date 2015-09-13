# Function to create exploratory plots of the "household_power_consumption.txt"
# dataset for the dates 1 Feb 2002 and 2 Feb 2002  
#
# Call function with directory and where "household_power_consumption.txt"
# file is stored.
#
# A PNG (plot4.png) of the histogram will be created in the same directory.
#
plot4 <- function(directory, file = 'household_power_consumption.txt'){
     
     # Find the original directory
     orig_dir <- getwd()
     
     # Change to directory containing data to plot
     setwd(directory)
     
     # Read in the data
     x <- read.csv(file,header = T,na.strings = "?",comment.char="",sep=";")
     
     # Subset the data - only using data from 2007-02-01 and 2007-02-02
     # Data from date 1
     d1 <- x[x$Date == "1/2/2007",]
     # Data from date 2
     d2 <- x[x$Date == "2/2/2007",]
     # Merge data from date 1 and date 2
     d <- rbind(d1,d2)
     # Remove excess data from memory
     remove(d1,d2,x)
     
     # Combine Date and Time columns
     Datetime = paste(as.Date(d$Date,format="%d/%m/%Y"),d$Time)
     
     #Convert Datetime field to "Date" datatype
     Datetime = strptime(Datetime, format="%Y-%m-%d %H:%M:%S")
     
     # Set up PNG device to write plot to PNG file
     png(filename = 'plot4.png', width = 480, height = 480, bg="transparent")
     
     # Set up a figure with 2 rows and 2 columns
     par(mfrow = c(2,2))
     
     # Create the plots
     # Top-left plot
     plot(Datetime,d$Global_active_power,type="l",xlab="",
          ylab = "Global Active Power (kilowatts)")
     
     # Top-right plot
     plot(Datetime,d$Voltage, type="l",xlab="datetime",
          ylab = "Voltage")
     
     # Bottom-left plot
     plot(Datetime,d$Sub_metering_1,type="n",xlab="",
          ylab = "Energy sub metering")
     points(Datetime, d$Sub_metering_1, type="l", col="black")
     points(Datetime, d$Sub_metering_2, type="l", col="red")
     points(Datetime, d$Sub_metering_3, type="l", col="blue")
     #Add legend
     legend("topright",                         # location of legend
            col=c("black","blue","red"),        # colors of lines
            legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
            lty = c(1,1,1))                     # style of lines in legend
     
     # Bottom-right plot
     plot(Datetime, d$Global_reactive_power, type="l",
          xlab="datetime",ylab="Global_reactive_power")
     
     # Close the PNG device
     dev.off()
     
     # Reset directory to original directory
     setwd(orig_dir)
}