### Loading the data##########
NEI <- readRDS("summarySCC_PM25.rds")
siSCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

#find coal combustion -related sources
coal_combustion<-grep("combustion.*coal",siSCC$SCC.Level.Four,ignore.case = TRUE)

#extract SCC for coal combustion -related sources
coal_combustion_SCC<-(siSCC %>% slice(coal_combustion))$SCC

#find all emissions coal combustion -related sources 
all_coal_combustion<-NEI %>% filter(SCC %in% coal_combustion_SCC)

#draw plot
c<-ggplot(all_coal_combustion,aes(x = factor(year), y = Emissions/1000))
c + geom_bar(stat = "identity",fill="#FF9999")+
        ggtitle("Coal combustion across USA")+
        xlab("Year")+
        ylab("PM2.5 in thousands")

#save to PNG
dev.copy(png,"plot4.png")
dev.off()