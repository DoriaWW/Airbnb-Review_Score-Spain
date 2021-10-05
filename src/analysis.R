### install.packages("ggplot2")；install.packages("fixest")；install.packages("broom");install.packages("modelsummary");install.packages("rlist")

##library
library(dplyr); library(ggplot2); library(fixest); library(broom); library(modelsummary); library(rlist)

##load data
listings_all <- read.csv("output/listings_all.csv")

##overview of the data
table_descriptives1 <- listings_all %>%
  group_by(size) %>%
  summarize(mean_rating = mean(review_scores_rating),
            mean_number_reviews = mean(number_of_reviews),
            number_private_rooms = sum(room_type_private),
            number_hotel_rooms = sum(room_type_hotel),
            number_entire_rooms = sum(room_type_entire),
            number_shared_rooms = sum((room_type_entire == 0) & (room_type_hotel ==0) & (room_type_private ==0)),
            number_of_superhosts = sum(as.numeric(host_is_superhost)))


table_descriptives2 <- listings_all %>%
  group_by(size) %>%
  count()

table_descriptives3 <- table_descriptives1 %>%
  inner_join(table_descriptives2, by = "size")

table_descriptives3 <- table_descriptives3 %>%
  mutate(ratio_superhosts = number_of_superhosts / n, table_descriptives3) %>%
  mutate(across(where(is.numeric), ~ round(., digits = 3)))  


table_descriptives <- rbind(table_descriptives3, c("Total", 
                                 colMeans(listings_all[,c("review_scores_rating", "number_of_reviews")]), 
                                 colSums(listings_all[,c("room_type_private", "room_type_hotel", "room_type_entire")]), nrow(listings_all)-sum(listings_all[,c("room_type_private", "room_type_hotel", "room_type_entire")]),
                                 sum(listings_all[,"host_is_superhost"]), nrow(listings_all), sum(listings_all[,"host_is_superhost"])/nrow(listings_all))) %>%
  mutate_at(vars(mean_rating, mean_number_reviews, number_private_rooms, number_hotel_rooms, number_entire_rooms, number_shared_rooms, number_of_superhosts, n, ratio_superhosts), as.numeric) %>%
  mutate(across(where(is.numeric), ~ round(., digits = 3))) %>% mutate_each(funs(round(.,0)), mean_number_reviews); rm(table_descriptives1); rm(table_descriptives2); rm(table_descriptives3)

saveRDS(table_descriptives, file = "output/table_descriptives.RDS") 

superhost_descriptives <- listings_all %>%
  group_by(host_is_superhost) %>%
  summarize(mean_number_reviews = mean(number_of_reviews), mean_rating = mean(review_scores_rating)) %>% 
  mutate_each(funs(round(.,0)), mean_number_reviews) %>% mutate_each(funs(round(.,2)), mean_rating)

saveRDS(superhost_descriptives, file = "output/superhost_descriptives.RDS") 

#This table shows that listings owned by a "superhost" (which is the case when host_is_superhost = 1) receive more than double the number of reviews than listings that are not owned by a "superhost". Moreover, the overall rating is quite higher for this group.

room_type_descriptives <- listings_all %>%
  group_by(room_type) %>%
  summarize(mean_number_reviews = mean(number_of_reviews), mean_rating = mean(review_scores_rating)) %>%
  mutate_each(funs(round(.,0)), mean_number_reviews) %>% mutate_each(funs(round(.,2)), mean_rating) %>%
  arrange(desc(mean_number_reviews, mean_rating))

saveRDS(room_type_descriptives, file = "output/room_type_descriptives.RDS") 

#This table shows that room types "Entire home" and "private room" get almost double the amount of reviews compared to "shared room" and "hotel room". No significant difference in terms of ratings can be seen between these room types, although shared rooms stands out a little bit in last place.

size_descriptives <- listings_all %>%
  group_by(size) %>%
  summarize(mean_number_reviews = mean(number_of_reviews), mean_rating = mean(review_scores_rating)) %>%
  mutate_each(funs(round(.,0)), mean_number_reviews) %>% mutate_each(funs(round(.,2)), mean_rating) %>%
  arrange(desc(mean_number_reviews, mean_rating)) %>% arrange(size)

saveRDS(size_descriptives, file = "output/size_descriptives.RDS") 

#In this table, it can be seen that the medium and large cities get way more reviews than smaller-sized cities. In terms of the overall rating, the three sizes score about the same. 

## Regression
regression <- lm(review_scores_rating ~ host_is_superhost*number_of_reviews + room_type_private*number_of_reviews + room_type_hotel*number_of_reviews + room_type_entire*number_of_reviews + size_small*number_of_reviews + size_medium*number_of_reviews, listings_all)
summary(regression)

#The regression output shows that the moderators, when viewing them as independent variables are significant, except for the number of reviews (B=1.46*10-3, p=.06). Furthermore, when looking at how the moderators
#influence the relationship between the rating and the number of reviews, it can be seen that the superhost and city size moderators are significant (p<.01), whereas the room type is not significant at all. 


listings_all %>% 
  ggplot(aes(x = number_of_reviews, y = review_scores_rating)) +
  geom_point() + 
  xlab("Number of reviews") +
  ylab("Overall rating") +
  ggtitle("Overview of rating scores")
  

  
  
  
  
  
  
  
  
regression <- feols(review_scores_rating ~ review_scores_location + review_scores_value + number_of_reviews + review_scores_cleanliness + review_scores_checkin + review_scores_communication + review_scores_accuracy
                      |
                        size,
                      cluster = ~size,
                      data = listings_all)
tidy(regression, se = 'cluster', conf.int = TRUE)
list.save(regression, 'output/regression.Rds')

msummary(regression,
           coef_omit = "Interc",
           gof_omit = "AIC|BIC|Log|Pseudo|F",
           output = "output/regression_table.png")