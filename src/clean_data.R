## Add city ID
listings_all <- read.csv("temp/listings_all_raw.csv")
listings_all$city = gsub('data[/]listings[_]', '', listings_all$filename)
listings_all$city = gsub('[.]csv', '', listings_all$city)

## Extract columns and delete missing values
cols_to_keep =  c('host_is_superhost', 'room_type', 'number_of_reviews', 'review_scores_rating', 'city')
listings_all <- na.omit(listings_all[ , (colnames(listings_all) %in% cols_to_keep)]); #rm(listings); rm(all_files); rm(cols_to_keep)

## Add city size
listings_all[listings_all$city %in% c("barcelona", "madrid"), "city_size"] <- "Big"
listings_all[listings_all$city %in% c("malaga", "sevilla","valencia"), "city_size"] <- "Medium"
listings_all[listings_all$city %in% c("girona", "menorca"), "city_size"] <- "Small"

## Create dummy variable for moderators (room type, city size and superhost)
listings_all$room_type_private = ifelse(listings_all$room_type == "Private room", 1, 0)
listings_all$room_type_hotel = ifelse(listings_all$room_type == "Hotel room", 1, 0)
listings_all$room_type_entire = ifelse(listings_all$room_type == "Entire home/apt", 1, 0)
listings_all$city_size_small = ifelse(listings_all$city_size == "Small", 1, 0)
listings_all$city_size_medium = ifelse(listings_all$city_size == "Medium", 1, 0)
listings_all$host_is_superhost = as.numeric(ifelse(listings_all$host_is_superhost == "t", 1, 0))

## Reallocate columns
listings_all <- listings_all[,c("city", "review_scores_rating", "number_of_reviews", "host_is_superhost", "room_type", "room_type_private", "room_type_hotel", "room_type_entire", "city_size", "city_size_small", "city_size_medium")]

## Output file
write.csv(listings_all,"temp/listings_all.csv", row.names = FALSE)