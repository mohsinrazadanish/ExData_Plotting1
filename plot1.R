# The memory check was done and the data can be read in the memory
# Getting complete dataset

data <- read.table("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                   nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')           
                   
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
                   
# Subsetting the data
                   
my_data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
                   
# Garbage Collection, clear un-necessary variables from memory
rm(data)

# Converting dates          
datetime <- paste(as.Date(my_data$Date), my_data$Time)
my_data$Datetime <- as.POSIXct(datetime)

# Plot 1
hist(my_data$Global_active_power, main="Global Active Power", 
xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)                   
dev.off()