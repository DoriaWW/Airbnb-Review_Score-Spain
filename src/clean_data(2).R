## Setup
### install.packages("tidyverse"); install.packages("dplyr")
library(tidyverse); library(dplyr)
library(readr)

## Add data into R
all_files <- list.files('data', pattern = 'listings', full.names=T)
listings <- lapply(all_files, function(x) {
  print(x)
  df <- read.csv(x)
  df$filename = x
  return(df)
})
combined_dataset = do.call('rbind', listings)

## Modify city name
combined_dataset$city = gsub('data[/]listings[_]', '', combined_dataset$filename)
combined_dataset$city = gsub('[.]csv', '', combined_dataset$city)

## Extract columns and delete missing value
cols_to_keep =  c('host_is_superhost', 'room_type', 'number_of_reviews', 'review_scores_rating', 'review_scores_value', 'city')
new_dataset <- combined_dataset[ , (colnames(combined_dataset) %in% cols_to_keep)]
listings_all <- na.omit(new_dataset)

## Add size to city
listings_all$size <- listings_all$city
levels(listings_all$size) <- c(levels(listings_all$size),"big")
listings_all[listings_all$city %in% c("barcelona", "madrid"), "size"] <- "big"
listings_all[listings_all$city %in% c("malaga", "sevilla","valencia"), "size"] <- "medium"
listings_all[listings_all$city %in% c("girona", "menorca"), "size"] <- "small"

## Create dummy variable for moderators (room type, city size and superhost)
listings_all$room_type_private = ifelse(listings_all$room_type == "Private room", 1, 0)
listings_all$room_type_hotel = ifelse(listings_all$room_type == "Hotel room", 1, 0)
listings_all$room_type_entire = ifelse(listings_all$room_type == "Entire home/apt", 1, 0)
listings_all$size_small = ifelse(listings_all$size == "Small", 1, 0)
listings_all$size_medium = ifelse(listings_all$size == "Medium", 1, 0)
listings_all$host_is_superhost = as.numeric(ifelse(listings_all$host_is_superhost == "t", 1, 0))

## Reallocate columns
listings_all <- listings_all[,c("host_is_superhost", "room_type", "room_type_private", "room_type_hotel", "room_type_entire", "number_of_reviews", "review_scores_rating", "review_scores_accuracy", "review_scores_cleanliness", "review_scores_checkin", "review_scores_communication", "review_scores_location", "review_scores_value", "city", "size", "size_small", "size_medium")]

## Output file
dir.create("output")
write.csv(listings_all,"output/listings_all.csv", row.names = FALSE)
