##library
library(dplyr)
library(ggplot2)
##load data
listings <- read.csv("output/listings_all.csv")

##overview of the data
table_descriptives1 <- listings_all %>%
  group_by(size) %>%
  summarize(mean_reviews_rating = mean(review_scores_rating),
            mean_reviews_location = mean(review_scores_location),
            mean_reviews_value = mean(review_scores_value),
            mean_number_of_reviews = mean(number_of_reviews),
            mean_reviews_cleanliness = mean(review_scores_cleanliness),
            mean_reviews_checkin = mean(review_scores_checkin),
            mean_reviews_communication = mean(review_scores_communication),
            mean_reviews_accuracy = mean(review_scores_accuracy),
            number_of_private_rooms = sum(room_type_private),
            number_of_hotel_rooms = sum(room_type_hotel),
            number_of_entire_rooms = sum(room_type_entire),
            number_of_shared_rooms = sum((room_type_entire == 0) & (room_type_hotel ==0) & (room_type_private ==0)),
            number_of_superhosts = sum(as.numeric(host_is_superhost)))

table_descriptives2 <- listings_all %>%
  group_by(size) %>%
  count()

table_descriptives <- table_descriptives1 %>%
  inner_join(table_descriptives2, by = "size")

table_descriptives <- mutate(ratio_superhosts = number_of_superhosts / n, table_descriptives)


listings %>%  
  ggplot(aes(x = city,y = mean(review_scores_rating))) +
  geom_bar(position="dodge", stat="identity") +
  facet_wrap(~ size) +
  theme_bw() +
  ylab("Socre") +
  xlab("Cities") +
  ggtitle("Overview of rating scores")