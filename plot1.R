#################################################################################

# Fetching the data

# The memory check was done and the data can be read in the memory

# I assume that the data file "household_power_consumption.txt" is in the working directory,
# if it is not the case, the script attempts to download the zip file, unzip it to get the
# data file in the working directory

# The download.file method works for me using R version 3.2.4 on windows 7 with "wininet"

if(!file.exists("household_power_consumption.txt")) {
  
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  destfile <- "consumption.zip"
  download.file(url, destfile, "wininet")
  unzip("consumption.zip")
}

filename <- "household_power_consumption.txt"

# The script checks if the sqldf package is already installed
# If not, it attempts to install and then load the sqldf package

if(!is.element('sqldf', installed.packages()[,1]))
{install.packages('sqldf')
}
library(sqldf)

# Next, I use the sqldf package's read.csv.sql function to read the data
# Instead of getting complete dataset, I only fetch the data for 1/2/2007 or 2/2/2007

tab5rows <- read.table(filename, header = TRUE, nrows = 5, sep=";") # to get classes
classes <- sapply(tab5rows, class)

data <- read.csv.sql(filename, sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', sep=";", colClasses = classes)

data$Date <- as.Date(data$Date, "%d/%m/%Y")

Sys.setlocale("LC_TIME", "English") # Windows

DateTime<-paste(data$Date,data$Time)
data$DateTime <- strptime(DateTime, "%Y-%m-%d %H:%M:%S")

# To set the xlim explicitly
xlims <- as.numeric(c(data$DateTime[1],data$DateTime[2880]))
t<-c(data$DateTime[1],data$DateTime[2880])

############################################################################

# Plotting

# Plot1

png("plot1.png", width=480,height=480, units="px", bg="transparent")

hist(data$Global_active_power,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

axis(side = 1, lwd=2)
axis(side = 2, lwd = 2)

dev.off()