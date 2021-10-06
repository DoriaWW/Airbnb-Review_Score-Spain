## Setup
library(tidyverse); library(dplyr); library(readr)

## load combined dataset
combined_dataset <- read.csv("data/combined.csv")

## Modify city name
combined_dataset$city = gsub('data[/]listings[_]', '', combined_dataset$filename)
combined_dataset$city = gsub('[.]csv', '', combined_dataset$city)

## Extract columns and delete missing value
cols_to_keep =  c('host_is_superhost', 'room_type', 'number_of_reviews', 'review_scores_rating', 'city')
listings_all <- na.omit(combined_dataset[ , (colnames(combined_dataset) %in% cols_to_keep)]);rm(combined_dataset); rm(listings); rm(all_files); rm(cols_to_keep)

## Add size to city
listings_all[listings_all$city %in% c("barcelona", "madrid"), "size"] <- "Big"
listings_all[listings_all$city %in% c("malaga", "sevilla","valencia"), "size"] <- "Medium"
listings_all[listings_all$city %in% c("girona", "menorca"), "size"] <- "Small"

## Create dummy variable for moderators (room type, city size and superhost)
listings_all$room_type_private = ifelse(listings_all$room_type == "Private room", 1, 0)
listings_all$room_type_hotel = ifelse(listings_all$room_type == "Hotel room", 1, 0)
listings_all$room_type_entire = ifelse(listings_all$room_type == "Entire home/apt", 1, 0)
listings_all$size_small = ifelse(listings_all$size == "Small", 1, 0)
listings_all$size_medium = ifelse(listings_all$size == "Medium", 1, 0)
listings_all$host_is_superhost = as.numeric(ifelse(listings_all$host_is_superhost == "t", 1, 0))

## Reallocate columns
listings_all <- listings_all[,c("review_scores_rating", "number_of_reviews", "host_is_superhost", "room_type", "room_type_private", "room_type_hotel", "room_type_entire", "size", "size_small", "size_medium", "city")]

## Output file
dir.create("output")
write.csv(listings_all,"output/listings_all.csv", row.names = FALSE)

