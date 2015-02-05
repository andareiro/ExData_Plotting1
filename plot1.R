## Read the source data file
filename <- "household_power_consumption.txt"
raw <- read.csv(filename, header = T, sep=";", na.strings = "?")

## Transform the date variable, filter out the relevant dates,
## and the transform the time variable
raw <- transform(raw, Date = as.Date(Date, "%d/%m/%Y"))
data <- filter(raw, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))
rm("raw")
data <- transform(data, datetime = strptime( paste( Date, Time ), "%Y-%m-%d %H:%M:%S"))

## Set up our plot
hist(data$Global_active_power,col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

## Write our output to a PNG file
dev.copy(png, file = "plot1.png")
dev.off()