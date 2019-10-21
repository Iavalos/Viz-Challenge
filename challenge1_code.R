library(tidyverse)
library(treemapify)
setwd("C:/Users/Ilse Avalos/Documents/UCL/Energy Data Analysis/Lectures/Challenge") #Set directory
mex <- read.csv("biee_industry.csv", stringsAsFactors = F) #Load data in csv 

#Clean data ----
mex_l <- gather(data = mex, key = "Year", value = "Ktoe", 5:31)
mex_l$Year <- gsub(pattern = "X", "", mex_l$Year)
mex_l$Ktoe <- as.numeric(mex_l$Ktoe)
mex_l[is.na(mex_l)] <- 0
mex_16 <-  filter(mex_l, Year == "2016" & Ktoe != 0) #Keep only values of 2016
rm(mex, mex_1)

#Create plot ----
ggplot(mex_16, aes(area = Ktoe, fill = Source, label = Code, subgroup = Source)) + 
  # area is the current value
  # fill is the name of category of energy 
  # label is the category of each Industry
  geom_treemap() +
  geom_treemap_subgroup_border() +
  geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.5, colour =
                               "black", fontface = "italic", min.size = 0) +
  geom_treemap_text(colour = "white", place = "topleft", reflow = T)+ 
  #color codes obtained from: http://colorbrewer2.org/
  scale_fill_manual(values = c("#d8b365", "#8c510a","#003c30","#35978f","#01665e", "#543005"),
                    labels=c("Coal", "Comb. Renewables", "Electricity","Gas", "Oil","Other sources" ))+
  labs(title = "Industry energy consumption by source in Mexico, 2016", 
       caption = "Source: Mexican Ministry of Energy (SENER), 2017. 
\n*Other sub-sectors includes all remaining manufacturing sub-sectors; 
Comb. renewables includes combustible renewables and waste;
       Other sources includes heat and other energy sources.")


