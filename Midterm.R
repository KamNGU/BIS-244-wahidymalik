# Midterm by Malik Wahidy

# Clear WD and Console
rm(list=ls(all=TRUE))
cat("\014")

library(tidyverse)
library(here)
library(readr)
library(ggplot2)

AAPL <- read_csv("AAPL.csv")

AAPL$Change <- 0
AAPL$Direction <- NA

for (x in 2:252) {
  AAPL$Change[x] <- AAPL$`Adj Close`[x]-AAPL$`Adj Close`[x-1]
}

for (x in 1:252) {
  if(AAPL$Change[x] > 0) {
    AAPL$Direction[x] = "Up"
  }
  else if(AAPL$Change[x] < 0) {
    AAPL$Direction[x] = "Down"
  }
  else {
    AAPL$Direction[x] = "NA"
  }
}

# Plotting

p <- ggplot(data=AAPL, aes(x = Date, y = Change, color = UpDown))
p <- p + geom_point(aes(color = Direction)) + 
  labs (x = "03/19/2020 through 03/18/2021", y ="Changes in Adjusted Closing Price", 
        title = "Changes in AAPL Daily Prices over Last 5 Years",
        subtitle = "Malik Wahidy")

plot(p)
