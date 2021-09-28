##library
library(dplyr)
library(ggplot2)
##load data
listings <- read.csv("output/listings_all.csv")

##overview of the data
Table <-listings_all %>%
  group_by(size) %>%
  summarize(mean_reviews_rating = mean(review_scores_rating),
            mean_reviews_location = mean(review_scores_location),
            mean_reviews_value = mean(review_scores_value),
            mean_number_of_reviews = mean(number_of_reviews),
            mean_reviews_cleanliness = mean(review_scores_cleanliness),
            mean_reviews_checkin = mean(review_scores_checkin),
            mean_reviews_communication = mean(review_scores_communication),
            mean_reviews_accuracy = mean(review_scores_accuracy))


listings %>%  
  ggplot(aes(x = city,y = mean(review_scores_rating))) +
  geom_bar(position="dodge", stat="identity") +
  facet_wrap(~ size) +
  theme_bw() +
  ylab("Socre") +
  xlab("Cities") +
  ggtitle("Overview of rating scores")