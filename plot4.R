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
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

with(data, {plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power", xlab="")
            plot(datetime, Voltage, type = "l")
            plot(datetime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
              lines(datetime, Sub_metering_2, col="red")
              lines(datetime, Sub_metering_3, col="blue")
              legend("topright", lty=1, bty = "o", border = "white", col = c("black", "blue", "red"), legend = names(data)[7:9])
            plot(datetime, Global_reactive_power, type="l")})

## Save our PNG output
dev.copy(png, file = "plot4.png")
dev.off()
