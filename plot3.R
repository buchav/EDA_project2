### Loading the data##########
NEI <- readRDS("summarySCC_PM25.rds")
siSCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

#calculate total emissions per year for Baltimore City fips=="24510"
Year_Emissions<-NEI %>% filter(fips==24510) %>% group_by(year,type) %>% summarise(Emissions=sum(Emissions/1000))

#draw plot
c<-ggplot(Year_Emissions,aes(x = factor(year), y = Emissions,fill=type))
c + geom_bar(stat = "identity")+facet_wrap(~ type)+ggtitle("Baltimore City")+xlab("Year")+ylab("PM2.5 in thousands")

#save to PNG
dev.copy(png,"plot3.png")
dev.off()
