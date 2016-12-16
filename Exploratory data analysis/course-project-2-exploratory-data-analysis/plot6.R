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
angeles <- subset(Resumen, SCC %in% codes & fips == '06037')
angeles$fips <- 'Angeles'
baltimore <- subset(Resumen, SCC %in% codes & fips == '24510')
baltimore$fips <- 'Baltimore'
a <- rbind(angeles, baltimore)
# We plot to show the that emissions in U.S. from 1998-2008 have been changed increased respec to  2005
# but decreased with respect 1999
a <- a %>% group_by(fips,year) %>% summarize(Emissions = sum(Emissions, na.rm = TRUE))

ggplot(data = a, aes(x = year, y = Emissions, colour = factor(fips))) + geom_line() +
	ylab("Emissions (log(Tons))") + theme_bw() + scale_y_log10() + ggtitle('Emissions of Motor vehicles')+
	theme(legend.title=element_blank())+geom_smooth()+ facet_wrap(~fips)


dev.copy(png, "plot6.png", width = 480, height = 480)
dev.off()

