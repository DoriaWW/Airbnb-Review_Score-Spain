## Libraries
install.packages(haven)
install.packages(googledrive)
library(haven)
library(googledrive)
library(tidyverse)

## Original Data file
dir.create(("data"), showWarnings = FALSE)
data_id <-"11MaNZ2_XatX9OGZNkJnY9mWSPsZHuu3U"
out_file <- "data/listings_barcelona.csv"
drive_download(as_id(data_id), 
               path = out_file, 
               overwrite = TRUE)

data_id <-"1hSCeEx0FySiw2J8cEt6iAKDIoK-7KDxN"
out_file <- "data/listings_girona.csv"
drive_download(as_id(data_id), 
               path = out_file, 
               overwrite = TRUE)

data_id <-"1ftXX8qpWq0iXcAHN4SGzcY8BMWU0UrGV"
out_file <- "data/listings_madrid.csv"
drive_download(as_id(data_id), 
               path = out_file, 
               overwrite = TRUE)

data_id <-"10QZ9KuXmtIBdGUqv290vXY9ucTzrK8wR"
out_file <- "data/listings_malaga.csv"
drive_download(as_id(data_id), 
               path = out_file, 
               overwrite = TRUE)

data_id <-"1K3FaAC5wBwm71IH31z7L87TCSS2HTImS"
out_file <- "data/listings_menorca.csv"
drive_download(as_id(data_id), 
               path = out_file, 
               overwrite = TRUE)

data_id <-"1zQmeH6kdUdXogeqQTb8avmkOA3BOgFG3"
out_file <- "data/listings_sevilla.csv"
drive_download(as_id(data_id), 
               path = out_file, 
               overwrite = TRUE)

data_id <-"1AJzjZAgHqYsVQu2P9tsC-M-zWwJoA7p-"
out_file <- "data/listings_valencia.csv"
drive_download(as_id(data_id), 
               path = out_file, 
               overwrite = TRUE)
rm(data_id, out_file)

## Add data into R
listings_barcelona <- read.csv("data/listings_barcelona.csv")
listings_girona <- read.csv("data/listings_girona.csv")
listings_madrid <- read.csv("data/listings_madrid.csv")
listings_malaga <- read.csv("data/listings_malaga.csv")
listings_menorca <- read.csv("data/listings_menorca.csv")
listings_sevilla <- read.csv("data/listings_sevilla.csv")
listings_valencia <- read.csv("data/listings_valencia.csv")

## Add column with city
listings_barcelona$city <- "Barcelona"
listings_girona$city <- "Girona"
listings_madrid$city <- "Madrid"
listings_malaga$city <- "Malaga"
listings_menorca$city <- "Menorca"
listings_sevilla$city <- "Sevilla"
listings_valencia$city <- "Valencia"

## Adding dummy variable for city size small/medium/big
listings_barcelona$size_small <- 0
listings_barcelona$size_medium <- 0
listings_girona$size_small <- 1
listings_girona$size_medium <- 0
listings_madrid$size_small <- 0
listings_madrid$size_medium <- 0
listings_malaga$size_small <- 0
listings_malaga$size_medium <- 1
listings_menorca$size_small <- 1
listings_menorca$size_medium <- 0
listings_sevilla$size_small <- 0
listings_sevilla$size_medium <- 1
listings_valencia$size_small <- 0
listings_valencia$size_medium <- 1

## Creating a data frame
listings_barcelona <- listings_barcelona %>% select(18, 33, 56, 61:67, 75:77)
listings_girona <- listings_girona %>% select(18, 33, 56, 61:67, 75:77)
listings_madrid <- listings_madrid %>% select(18, 33, 56, 61:67, 75:77)
listings_malaga <- listings_malaga %>% select(18, 33, 56, 61:67, 75:77)
listings_menorca <- listings_menorca %>% select(18, 33, 56, 61:67, 75:77)
listings_sevilla <- listings_sevilla %>% select(18, 33, 56, 61:67, 75:77)
listings_valencia <- listings_valencia %>% select(18, 33, 56, 61:67, 75:77)

## Deleting missing values
listings_barcelona <- na.omit(listings_barcelona)
listings_girona <- na.omit(listings_girona)
listings_madrid <- na.omit(listings_madrid)
listings_malaga <- na.omit(listings_malaga)
listings_menorca <- na.omit(listings_menorca)
listings_sevilla <- na.omit(listings_sevilla)
listings_valencia <- na.omit(listings_valencia)