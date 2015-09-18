### Loading the data##########
NEI <- readRDS("summarySCC_PM25.rds")
siSCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

#extract SCC for On road motor vehicle
vehicle_SCC<-(siSCC %>% filter(Data.Category=="Onroad"))$SCC

#find all emissions motor vehicle sources in Baltimore (fips==24510) 
all_onRoad<-NEI %>% filter(SCC %in% vehicle_SCC,fips==24510)

#draw plot
c<-ggplot(all_onRoad,aes(x = factor(year), y = Emissions/1000))
c + geom_bar(stat = "identity",fill="#FF9999")+
        ggtitle("Motor vehicle emissions in Baltimore")+
        xlab("Year")+
        ylab("PM2.5 in thousands")

#save to PNG
dev.copy(png,"plot5.png")
dev.off()
