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
with(data, plot(datetime, Global_active_power, pch="", ylab = "Global Active Power (kilowatts)"))
with(data, lines(datetime, Global_active_power))

## Write to our image file
dev.copy(png, file = "plot2.png")
dev.off()
