## Setup
library(dplyr); library(modelsummary); library(ggplot2); library(webshot)

## Load file
listings_all <- read.csv("gen/temp/listings_all.csv")

## Plotting the number of reviews against the rating.
plot <- listings_all %>% 
  ggplot(aes(x = number_of_reviews, y = review_scores_rating)) +
  geom_point() + 
  xlab("Number of reviews") +
  ylab("Overall rating") +
  ggtitle("Overview_of_rating_scores")
ggsave("gen/output/Overview_of_rating_scores.jpg", height = 10, width = 15, units = "in")

## Regression and output file
regression <- lm(review_scores_rating ~ host_is_superhost*number_of_reviews + room_type_private*number_of_reviews + room_type_hotel*number_of_reviews + room_type_entire*number_of_reviews + city_size_small*number_of_reviews + city_size_medium*number_of_reviews, listings_all)
webshot::install_phantomjs(force = TRUE)
msummary(regression,
         title = "Regression model",
         fmt = 4,
         estimate = "{estimate}{stars} | ({std.error})",
         statistic = NULL,
         gof_omit = "AIC|BIC|Log|Pseudo|F",
         output = "gen/output/regression.png")