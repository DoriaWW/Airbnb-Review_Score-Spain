##library
library(dplyr)
library(ggplot2)
##load data
listings <- read.csv("output/listings_all.csv")

##overview of the data
table_descriptives1 <- listings_all %>%
  group_by(size) %>%
  summarize(mean_rating = mean(review_scores_rating),
            mean_location = mean(review_scores_location),
            mean_value = mean(review_scores_value),
            mean_number_reviews = mean(number_of_reviews),
            mean_cleanliness = mean(review_scores_cleanliness),
            mean_checkin = mean(review_scores_checkin),
            mean_communication = mean(review_scores_communication),
            mean_accuracy = mean(review_scores_accuracy),
            number_private_rooms = sum(room_type_private),
            number_hotel_rooms = sum(room_type_hotel),
            number_entire_rooms = sum(room_type_entire),
            number_shared_rooms = sum((room_type_entire == 0) & (room_type_hotel ==0) & (room_type_private ==0)),
            number_of_superhosts = sum(as.numeric(host_is_superhost)))

table_descriptives2 <- listings_all %>%
  group_by(size) %>%
  count()

table_descriptives <- table_descriptives1 %>%
  inner_join(table_descriptives2, by = "size")

table_descriptives <- table_descriptives %>%
  mutate(ratio_superhosts = number_of_superhosts / n, table_descriptives) %>%
  mutate(across(where(is.numeric), ~ round(., digits = 2)))  


y <- rbind(table_descriptives, c("Total", 
                                 colMeans(listings_all[,c("review_scores_rating","review_scores_location", "review_scores_value", "number_of_reviews", "review_scores_cleanliness", "review_scores_checkin", "review_scores_communication", "review_scores_accuracy")]), 
                                 colSums(listings_all[,c("room_type_private", "room_type_hotel", "room_type_entire")]), nrow(listings_all)-sum(listings_all[,c("room_type_private", "room_type_hotel", "room_type_entire")]),
                                 sum(listings_all[,"host_is_superhost"]), nrow(listings_all), sum(listings_all[,"host_is_superhost"])/nrow(listings_all))) %>%
  mutate_at(vars(mean_rating, mean_location, mean_value, mean_number_reviews, mean_cleanliness, mean_checkin, mean_communication, mean_accuracy, number_private_rooms, number_hotel_rooms, number_entire_rooms, number_shared_rooms, number_of_superhosts, n, ratio_superhosts), as.numeric) %>%
  mutate(across(where(is.numeric), ~ round(., digits = 2)))  




listings %>%  
  ggplot(aes(x = city,y = mean(review_scores_rating))) +
  geom_bar(position="dodge", stat="identity") +
  facet_wrap(~ size) +
  theme_bw() +
  ylab("Socre") +
  xlab("Cities") +
  ggtitle("Overview of rating scores")