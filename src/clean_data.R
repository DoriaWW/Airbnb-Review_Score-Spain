## Setup
### install.packages("tidyverse"); install.packages("dplyr")
library(tidyverse); library(dplyr)

## Add data into R

all_files <- list.files('data', pattern = 'listings', full.names=T)

listings <- lapply(all_files, function(x) {
  print(x)
  df <- read.csv(x)
  df$filename = x
  
  return(df)
})


## Add column with city
listings_barcelona$city <- "Barcelona"
listings_girona$city <- "Girona"
listings_madrid$city <- "Madrid"
listings_malaga$city <- "Malaga"
listings_menorca$city <- "Menorca"
listings_sevilla$city <- "Sevilla"
listings_valencia$city <- "Valencia"

## Add size to city
listings_barcelona$size <- "Big"
listings_girona$size <- "Small"
listings_madrid$size <- "Big"
listings_malaga$size <- "Medium"
listings_menorca$size <- "Small"
listings_sevilla$size <- "Medium"
listings_valencia$size <- "Medium"

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
cols_to_keep =  c('host_is_superhost', 'room_type', 'number_of_reviews', 'review_scores_rating', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value', 'city', 'size', 'size_small', 'size_medium', 'size_large')

listings_barcelona <- na.omit(listings_barcelona[, which(colnames(listings_barcelona)%in%cols_to_keep)])
listings_girona <- na.omit(listings_girona[, which(colnames(listings_girona)%in%cols_to_keep)])
listings_madrid <- na.omit(listings_madrid[, which(colnames(listings_madrid)%in%cols_to_keep)])
listings_malaga <- na.omit(listings_malaga[, which(colnames(listings_malaga)%in%cols_to_keep)])
listings_menorca <- na.omit(listings_menorca[, which(colnames(listings_menorca)%in%cols_to_keep)])
listings_sevilla <- na.omit(listings_sevilla[, which(colnames(listings_sevilla)%in%cols_to_keep)])
listings_valencia <- na.omit(listings_valencia[, which(colnames(listings_valencia)%in%cols_to_keep)])
rm(cols_to_keep)

## Merged dataset (name: listings_all)
listings_all <- rbind(listings_barcelona,
                      listings_girona,
                      listings_madrid,
                      listings_malaga,
                      listings_menorca,
                      listings_sevilla,
                      listings_valencia)
rm(listings_barcelona,listings_girona,listings_madrid,listings_malaga,listings_menorca,listings_sevilla,listings_valencia)

## Create dummy variable for room_type
listings_all$room_type_private = ifelse(listings_all$room_type == "Private room", 1, 0)
listings_all$room_type_hotel = ifelse(listings_all$room_type == "Hotel room", 1, 0)
listings_all$room_type_entire = ifelse(listings_all$room_type == "Entire home/apt", 1, 0)
listings_all$host_is_superhost = as.numeric(ifelse(listings_all$host_is_superhost == "t", 1, 0))

## Reallocate columns
listings_all <- listings_all[,c("host_is_superhost", "room_type", "room_type_private", "room_type_hotel", "room_type_entire", "number_of_reviews", "review_scores_rating", "review_scores_accuracy", "review_scores_cleanliness", "review_scores_checkin", "review_scores_communication", "review_scores_location", "review_scores_value", "city", "size", "size_small", "size_medium")]


## Output file
dir.create('../output')
write.csv(listings_all,"../output/listings_all.csv", row.names = FALSE)
