# Load ggplot2 library
library(ggplot2)

# Loading provided datasets - loading from local machine
NEI <- readRDS("D:/Users/santi_000/Desktop/Coursera/Exploratory Data Analysis/Week-4/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("D:/Users/santi_000/Desktop/Coursera/Exploratory Data Analysis/Week-4/exdata_data_NEI_data/Source_Classification_Code.rds")


NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

# Generate the graph in the same directory as the source code
png('D:/Users/santi_000/Desktop/Coursera/Exploratory Data Analysis/Week-4/exdata_data_NEI_data/plot5.png')

ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
        ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
        ylab(expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + xlab('Year') + theme(legend.position='none') + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

ggp <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="grey",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))


dev.off()