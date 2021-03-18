install.packages("dplyr")
library(dplyr)

USStates <- read.csv("us-states.csv")
penn <- USStates %>% filter(state == "Pennsylvania")
adj_deaths <- penn %>% mutate(adj_deaths=deaths)

adj_deaths$adj_deaths[47]<-adj_deaths$adj_deaths[47]-282
adj_deaths$adj_deaths[48]<-adj_deaths$adj_deaths[48]-297
adj_deaths[47:48,1:6]

sum(adj_deaths$deaths)
sum(adj_deaths$adj_deaths)