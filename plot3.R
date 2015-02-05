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
with(data, {plot(datetime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
            lines(datetime, Sub_metering_2, col="red")
            lines(datetime, Sub_metering_3, col="blue")
            legend("topright", lty=1, col = c("black", "blue", "red"), legend = names(data)[7:9])})

## Save our PNG output
dev.copy(png, file = "plot3.png")
dev.off()
