### Loading the data##########
NEI <- readRDS("summarySCC_PM25.rds")
siSCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

#extract SCC for Onroad motor vehicle
vehicle_SCC<-(siSCC %>% filter(Data.Category=="Onroad"))$SCC

#find all emissions motor vehicle sources in Baltimore (fips==24510) and Los-Angeles (fips == "06037")
all_onRoad<-NEI %>% filter(SCC %in% vehicle_SCC,fips==24510|fips=="06037")%>% group_by(year,fips) %>% summarise(Emissions=sum(Emissions))
#convert fips to factor
all_onRoad$fips<-as.factor(all_onRoad$fips)
#rename factor levels
levels(all_onRoad$fips)<-c("Los Angeles","Baltimore")

#draw plot
c<-ggplot(all_onRoad,aes(x = factor(year), y = Emissions/1000,fill=fips))
c + geom_bar(stat = "identity",position="dodge")+
        ggtitle("Motor vehicle emissions")+
        xlab("Year")+
        ylab("PM2.5 in thousands")+scale_fill_discrete("City",labels = levels(all_onRoad$fips))

#save to PNG
dev.copy(png,"plot6.png")
dev.off()
