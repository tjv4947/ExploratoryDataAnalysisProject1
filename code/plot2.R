##  R File for plot2
##
##

# get data from file
##  Assumes file already has been downloaded 
#### could enhance to read file from internet if not already on disk
# Read data.  N.B. the code reads date and times in as character because trying 
##  to read them as date  was extremely slow

print("Beginning to read data from disk.")

    setwd("~/Coursera/DataScience/ExploratoryDataAnalysis/Assignment/Homework1")
    rawdata <- read.table("household_power_consumption.txt", sep=";", header=TRUE,  na.strings="?", 
                      colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# subset data based on date range we were given in assignment
## note dates are in DD/MM/YYYY format in file
    wrkdata <- rbind(rawdata[rawdata$Date == "1/2/2007", ], rawdata[rawdata$Date == "2/2/2007", ])

# create new date time column on working set
    dateTime <- strptime(paste(wrkdata$Date, wrkdata$Time), format="%d/%m/%Y %H:%M:%S")
    wrkdata <- cbind(wrkdata, dateTime)

# create labels needed for labels etc
    xrange <- c(unique(strftime(wrkdata$dateTime, format="%a")), strftime(max(wrkdata$dateTime)+1440, format="%a"))
    xlabelpos <- c(0, nrow(wrkdata)/2, nrow(wrkdata))

# create plot
print("     Creating plot.")
    par(mfrow = c(1, 1), mar = c(5, 4, 2, 2))
    plot(wrkdata$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n", frame.plot=T)
    Axis(side=1, at=xlabelpos, labels=xrange)

## write plot out to PNG file
print("     Writing plot to file.")

    ## If file exists delete it.  
    fn <- "plot2.png"
    if (file.exists(fn)) file.remove(fn)

    dev.copy(png, file = fn) ## Copy the plot to a PNG file
    dev.off() ## Close the PNG device

print("Finished.")