# The memory check was done and the data can be read in the memory

# Getting complete dataset
# The data file should be downloaded in the working directory
# titled "household_power_consumption.txt" without the quotes

data <- read.table("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                   stringsAsFactors=F)           


data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subsetting the data
my_data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Garbage Collection, clear un-necessary variables from memory
rm(data)

# Converting dates          
datetime <- paste(as.Date(my_data$Date), my_data$Time)
my_data$Datetime <- as.POSIXct(datetime)

# Plot 2
par(mfrow = c(1,1), oma=c(0,0,2,0), bg= "transparent")
plot(my_data$Global_active_power~my_data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")


# Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()