### Loading the data##########
NEI <- readRDS("summarySCC_PM25.rds")
siSCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
#calculate total emissions per year
Year_Emissions<-NEI %>% group_by(year) %>% summarise(Emissions=sum(Emissions/1000))

with (Year_Emissions, {
        barplot(Emissions,col="blue",names.arg =year ,ylab="PM2.5 in thousands")
        title (main="Total Emissions per Year",xlab="Year")
        })