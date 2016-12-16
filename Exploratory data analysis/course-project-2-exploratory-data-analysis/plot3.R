# Download and extract the datasets 
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
rawData <- unzip(temp,'summarySCC_PM25.rds')
Resumen <- readRDS(rawData)
rawData <- unzip(temp, 'Source_Classification_Code.rds')
Codes <- readRDS(rawData)

# For this task I will use the library -dplyr- because the object returned by the funtions:
# 'group_by', 'summarize' are easier to manipulate than the returned by 'tapply', also
# I ussually use the ibrary -lubridate-
library(dplyr)
library(lubridate)
library(ggplot2)
# Check for NA's 
sum(is.na(Resumen$year))
sum(is.na(Resumen$Emissions))
Resumen$year <- ymd(paste0( Resumen$year, "01-01")) 
a <- Resumen %>% group_by(type, year) %>% summarize(means = mean(Emissions, na.rm = TRUE))
ggplot(data = a, aes(x = year, y = means, colour = type)) + geom_line() +
	ylab("log(Tons)") + theme_bw() + scale_y_log10() + ggtitle('Emissions of PM2.5 in Baltimore City')
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()


