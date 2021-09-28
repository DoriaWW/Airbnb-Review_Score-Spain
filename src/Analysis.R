##library
library(dplyr)
library(ggplot2)
##load data
listings <- read.csv("output/listings_all.csv")

##overview of the data
Table <-listings %>%
  group_by(size_small, size_medium) %>%
  summarize(mean_review_rating = mean(review_scores_rating))


listings %>%  
  ggplot(aes(x = city,y = mean(review_scores_rating))) +
  geom_bar(position="dodge", stat="identity") +
  facet_wrap(~ size) +
  theme_bw() +
  ylab("Socre") +
  xlab("Cities") +
  ggtitle("Overview of rating scores")