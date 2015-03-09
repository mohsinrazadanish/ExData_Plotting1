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

# Plot 3
par(mfrow=c(1,1), bg="transparent")
with(my_data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6)

# Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()