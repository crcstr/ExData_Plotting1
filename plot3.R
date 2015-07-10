## Check data and download file if needed
if (!file.exists("household_power_consumption.txt")) {
    fileUrl <- paste0("https://d396qusza40orc.cloudfront.net/exdata",
                      "%2Fdata%2Fhousehold_power_consumption.zip")
    download.file(fileUrl, destfile = "power.zip", method = "curl")
    unzip("power.zip")
    file.remove("power.zip")
}

## Read the data
d <- read.table("household_power_consumption.txt",
                sep = ";",
                colClasses = c(rep("character", 2),
                    rep("numeric", 7)),
                na.strings = "?",
                ##nrow = 5,
                header = TRUE)

d$datetime <- paste(d$Date, d$Time, sep = " ")
d <- transform(d, Date = as.Date(Date, "%d/%m/%Y"),
               datetime = strptime(datetime, "%d/%m/%Y %H:%M:%S"))

## Subset
d <- subset(d, Date %in% as.Date(c("2007/02/01", "2007/02/02")))

## Plot 3
png(filename = "plot3.png", width = 480, height = 480)
with(d, {
    plot(datetime, Sub_metering_1,
         type = "l", col = "black",
         ylab = "Energy Sub Metering",
         xlab = "")
    lines(datetime, Sub_metering_2,
          type = "l", col = "red")
    lines(datetime, Sub_metering_3,
          type = "l", col = "blue")
})
legend("topright", lty = c(1, 1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
