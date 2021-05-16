# BIS244 Final Exam by Malik Wahidy

rm(list=ls(all=TRUE)) 
cat("\014") 

library(gapminder) 
library(tidyverse) 
library(ggrepel) 
library(socviz) 
library(grid) 
library(maps)
library(readr)
library(mapproj)

counties <- map_data("county")

colors <- c("#2E74C0", "#CB454A", "#FFFFFF") 

data <- read_csv("nyt_counties_final12042020.csv")
data <- as.data.frame(data)

data$region <- tolower(data$state)
data$party <- NA

length <- length(data$fips)

for (i in 1:length){
  if(data$trumpd[i] > data$bidenj[i]){
    data$party[i] <- "Republican"
  } else if (data$trumpd[i] < data$bidenj[i]){
    data$party[i] <- "Democratic"
  } 
}

data$subregion <- tolower(data$name)
election <- left_join(counties, data)

p <- ggplot(data = election,
            aes(x = long, y = lat,
                group = group, fill = party))

p + geom_polygon(color = "gray90", size = 0.1) + guides(fill = FALSE)

theme_map <- function(base_size=9, base_family="") {
  require(grid)
  theme_bw(base_size=base_size, base_family=base_family) %+replace%
    theme(axis.line=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank(),
          axis.title=element_blank(),
          panel.background=element_blank(),
          panel.border=element_blank(),
          panel.grid=element_blank(),
          panel.spacing=unit(0, "lines"),
          plot.background=element_blank(),
          legend.justification = c(0,0),
          legend.position = c(0,0)
    )
}

p1 <- ggplot(data = election,
             mapping = aes(x = long, y = lat,
                           group = group, fill = party))
p2 <- p1 + geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) 
p3 <- p2 + scale_fill_manual(values = colors) +
  labs(title = "Presidential Election Results 2020", subtitle = "created by Malik Wahidy 5/15/2021", fill = NULL)
p4 <- p3 + theme_map()
p4 + scale_y_continuous(breaks = NULL)