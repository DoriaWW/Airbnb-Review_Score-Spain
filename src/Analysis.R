##library
library(dplyr)
##load data
listings <- read.csv("output/listings_all.csv")

##overview of the data
Table<-listings %>%
  group_by(size_small, size_medium) %>%
  summarize(mean_review_rating = mean(review_scores_rating))
