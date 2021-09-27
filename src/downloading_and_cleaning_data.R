## Setup
# install.packages("haven"); install.packages("googledrive"); install.packages("tidyverse"); install.packages("dplyr")
library(haven); library(googledrive); library(tidyverse); library(dplyr)

## Downloading the data
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

## Selecting relevant columns and deleting missing values
cols_to_keep =  c('host_is_superhost', 'room_type', 'number_of_reviews', 'review_scores_rating', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value', 'city', 'size_small', 'size_medium', 'size_large')

listings_barcelona <- na.omit(listings_barcelona[, which(colnames(listings_barcelona)%in%cols_to_keep)])
listings_girona <- na.omit(listings_girona[, which(colnames(listings_girona)%in%cols_to_keep)])
listings_madrid <- na.omit(listings_madrid[, which(colnames(listings_madrid)%in%cols_to_keep)])
listings_malaga <- na.omit(listings_malaga[, which(colnames(listings_malaga)%in%cols_to_keep)])
listings_menorca <- na.omit(listings_menorca[, which(colnames(listings_menorca)%in%cols_to_keep)])
listings_sevilla <- na.omit(listings_sevilla[, which(colnames(listings_sevilla)%in%cols_to_keep)])
listings_valencia <- na.omit(listings_valencia[, which(colnames(listings_valencia)%in%cols_to_keep)])

## Merged dataset (name: listings_all)
listings_all <- rbind(listings_barcelona,
                      listings_girona,
                      listings_madrid,
                      listings_malaga,
                      listings_menorca,
                      listings_sevilla,
                      listings_valencia)

## Create dummy variable for room_type
listings_all$room_type_private = ifelse(listings_all$room_type == "Private room", 1, 0)
listings_all$room_type_hotel = ifelse(listings_all$room_type == "Hotel room", 1, 0)
listings_all$room_type_entire = ifelse(listings_all$room_type == "Entire home/apt", 1, 0)

# Reallocate columns
listings_all <- listings_all[,c(1, 2, 14, 15, 16, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 11)]
