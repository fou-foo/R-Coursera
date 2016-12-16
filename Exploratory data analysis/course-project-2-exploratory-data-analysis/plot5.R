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
library(RColorBrewer)

# Check for NA's 
sum(is.na(Resumen$year))
sum(is.na(Resumen$Emissions))
Resumen$year <- ymd(paste0( Resumen$year, "01-01")) 

# First we subset the data, searching for the sources with "Coal" within the variable -EI.Sector
codes <-  Codes$SCC[grep("Mobile", Codes$EI.Sector)] # Fuel - Comb, Coal 
codes <- unique(codes)
a <- subset(Resumen, SCC %in% codes & fips == '24510')

# We plot to show the that emissions in U.S. from 1998-2008 have been changed increased respec to  2005
# but decreased with respect 1999
a <- a %>% group_by(year) %>% summarize(Emissions = sum(Emissions, na.rm = TRUE))

ggplot(data = a, aes(x = factor(year(year)), y = Emissions)) + geom_bar(fill = brewer.pal(length(a$year), "PRGn"),
																		stat = "identity") +
	xlab("year") +ylab("Emissions (tons)")+ theme_bw() +  
	ggtitle('Emissions of PM2.5 in Baltimore City') + guides(fill=FALSE) 
dev.copy(png, "plot5.png", width = 480, height = 480)
dev.off()

