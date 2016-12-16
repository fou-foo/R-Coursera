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
# Check for NA's 
sum(is.na(Resumen$year))
sum(is.na(Resumen$Emissions))

# Subset data 
Baltimore <- subset(Resumen, fips == '24510')
a <- Baltimore %>% group_by(year) %>% summarize(means = mean(Emissions, na.rm = TRUE))
# Now we choose a very nice palette 
library(RColorBrewer)
p <-barplot(a$means, col = brewer.pal(length(a$means), "Set3"), names.arg = a$year, 
			xlab = '', ylab = 'Tons', main = 'Total PM2.5 emission (Baltimore, Maryland)')
text(p, a$means, format(round(a$means,2)),xpd = TRUE)
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()


