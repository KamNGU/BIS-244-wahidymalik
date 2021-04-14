rm(list=ls(all=TRUE))
cat("\014")

if (!require("tidyverse")) install.packages("tidyverse")
if (!require("here")) install.packages("here")

library(here)
library(tidyverse)
library(ggrepel)

counties <- read_csv(here("covid-19-data", "us-counties.csv"))
pennsylvania <- subset(counties, state=="Pennsylvania")

max <- pennsylvania[pennsylvania$date == max(pennsylvania$date),]

plot <- ggplot(data = max, mapping = aes(x = cases, y = deaths, label = county))

plot <- plot + geom_point() + geom_smooth(method = "lm", se = FALSE) + 
  geom_text_repel() +
  labs(x = "Cases", y = "Deaths", title = "COVID-19 Deaths vs Cases for PA as of 2021-03-04")

plot
