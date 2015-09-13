# Function to create a histogram of Global Active Power for the dates
# 1 Feb 2002 and 2 Feb 2002 from the dataset "household_power_consumption.txt"
#
# Call function with directory and where "household_power_consumption.txt"
# file is stored.
#
# A PNG (plot1.png) of the histogram will be created in the same directory.
#
plot1 <- function(directory, file = 'household_power_consumption.txt'){
     
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
     
     # Set up PNG device to write plot to PNG file
     png(filename = 'plot1.png', width = 480, height = 480, bg="transparent")
     # Create histogram
     hist(d$Global_active_power,col="red",
          xlab = 'Global Active Power (kilowatts)', 
          main ="Global Active Power", cex.main = 1.3)
     # Close the PNG device
     dev.off()
     
     # Reset directory to original directory
     setwd(orig_dir)
}