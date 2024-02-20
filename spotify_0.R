install.packages(c("brms", "tidyverse", "rstan"))
library(igraph)
library(xts)
library(rstan)
library(brms)
library(tidyverse)
library(lubridate)

data_spotify <- read.csv("/Users/ivanmendivelso/Documents/GitHub/more_spotify/data.csv")
data_spotify$explicit <- as.factor(data_spotify$explicit)
data_spotify$key <- as.factor(data_spotify$key)
data_spotify$mode <- as.factor(data_spotify$mode)
data_spotify$release_date <- ymd(data_spotify$release_date)
str(data_spotify)

# Visualize the distribution of popularity
ggplot(data_spotify, aes(x = popularity)) + geom_histogram(binwidth = 5)

muestra <- sample(1:nrow(data_spotify), 2000)
# Explore relationships
pairs(~popularity + duration_ms + danceability + acousticness + liveness + energy,
      data = data_spotify[muestra,])

pairs(~popularity  + instrumentalness + loudness + speechiness + tempo + valence + year,
      data = data_spotify[muestra,])

ggplot(data_spotify, aes(popularity, instrumentalness, col=loudness, ))
