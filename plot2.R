### Loading the data##########
NEI <- readRDS("summarySCC_PM25.rds")
siSCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

#calculate total emissions per year for Baltimore City fips=="24510"
Year_Emissions<-NEI %>% filter(fips==24510) %>% group_by(year) %>% summarise(Emissions=sum(Emissions/1000))

#draw barplot
with (Year_Emissions, {
        barplot(Emissions,col="blue",names.arg =year ,ylab="PM2.5 in thousands")
        title (main="Total Emissions in the Baltimore City",xlab="Year")
})

#save to PNG
dev.copy(png,"plot2.png")
dev.off()
