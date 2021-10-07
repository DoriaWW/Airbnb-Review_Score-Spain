## Setup
library(dplyr); library(modelsummary); library(ggplot2)
listings_all <- read.csv("temp/listings_all.csv")

## Overview of the data
table_descriptives1 <- listings_all %>%
  group_by(city_size) %>%
  summarize(mean_rating = mean(review_scores_rating),
            mean_number_reviews = mean(number_of_reviews),
            number_private_rooms = sum(room_type_private),
            number_hotel_rooms = sum(room_type_hotel),
            number_entire_rooms = sum(room_type_entire),
            number_shared_rooms = sum((room_type_entire == 0) & (room_type_hotel ==0) & (room_type_private ==0)),
            number_of_superhosts = sum(as.numeric(host_is_superhost)))


table_descriptives2 <- listings_all %>%
  group_by(city_size) %>%
  count()

table_descriptives3 <- table_descriptives1 %>%
  inner_join(table_descriptives2, by = "city_size")

table_descriptives3 <- table_descriptives3 %>%
  mutate(ratio_superhosts = number_of_superhosts / n, table_descriptives3) %>%
  mutate(across(where(is.numeric), ~ round(., digits = 3)))  


table_descriptives <- rbind(table_descriptives3, c("Total", 
                                 colMeans(listings_all[,c("review_scores_rating", "number_of_reviews")]), 
                                 colSums(listings_all[,c("room_type_private", "room_type_hotel", "room_type_entire")]), nrow(listings_all)-sum(listings_all[,c("room_type_private", "room_type_hotel", "room_type_entire")]),
                                 sum(listings_all[,"host_is_superhost"]), nrow(listings_all), sum(listings_all[,"host_is_superhost"])/nrow(listings_all))) %>%
  mutate_at(vars(mean_rating, mean_number_reviews, number_private_rooms, number_hotel_rooms, number_entire_rooms, number_shared_rooms, number_of_superhosts, n, ratio_superhosts), as.numeric) %>%
  mutate(across(where(is.numeric), ~ round(., digits = 3))) %>% mutate_each(funs(round(.,0)), mean_number_reviews); rm(table_descriptives1); rm(table_descriptives2); rm(table_descriptives3)

dir.create("output", showWarnings = FALSE)
saveRDS(table_descriptives, file = "output/table_descriptives.RDS") 

superhost_descriptives <- listings_all %>%
  group_by(host_is_superhost) %>%
  summarize(mean_number_reviews = mean(number_of_reviews), mean_rating = mean(review_scores_rating)) %>% 
  mutate_each(funs(round(.,0)), mean_number_reviews) %>% mutate_each(funs(round(.,2)), mean_rating)

saveRDS(superhost_descriptives, file = "output/superhost_descriptives.RDS") 

room_type_descriptives <- listings_all %>%
  group_by(room_type) %>%
  summarize(mean_number_reviews = mean(number_of_reviews), mean_rating = mean(review_scores_rating)) %>%
  mutate_each(funs(round(.,0)), mean_number_reviews) %>% mutate_each(funs(round(.,2)), mean_rating) %>%
  arrange(desc(mean_number_reviews, mean_rating))

saveRDS(room_type_descriptives, file = "output/room_type_descriptives.RDS") 

city_size_descriptives <- listings_all %>%
  group_by(city_size) %>%
  summarize(mean_number_reviews = mean(number_of_reviews), mean_rating = mean(review_scores_rating)) %>%
  mutate_each(funs(round(.,0)), mean_number_reviews) %>% mutate_each(funs(round(.,2)), mean_rating) %>%
  arrange(desc(mean_number_reviews, mean_rating)) %>% arrange(city_size)

saveRDS(city_size_descriptives, file = "output/city_size_descriptives.RDS") 


## Plotting the number of reviews against the rating
plot <- listings_all %>% 
  ggplot(aes(x = number_of_reviews, y = review_scores_rating)) +
  geom_point() + 
  xlab("Number of reviews") +
  ylab("Overall rating") +
  ggtitle("Overview of rating scores")


## Regression
regression <- lm(review_scores_rating ~ host_is_superhost*number_of_reviews + room_type_private*number_of_reviews + room_type_hotel*number_of_reviews + room_type_entire*number_of_reviews + city_size_small*number_of_reviews + city_size_medium*number_of_reviews, listings_all)
regression_output <- msummary(regression,
                              title = "Regression model",
                              fmt = 4,
                              estimate = "{estimate}{stars} | ({std.error})",
                              statistic = NULL,
                              gof_omit = "AIC|BIC|Log|Pseudo|F")



