# Download data Madrid (Biggest city to start with)
download.file("http://data.insideairbnb.com/spain/comunidad-de-madrid/madrid/2021-07-07/data/listings.csv.gz", "data/Listings_Madrid.csv")
download.file("http://data.insideairbnb.com/spain/comunidad-de-madrid/madrid/2021-07-07/data/reviews.csv.gz", "data/Reviews_Madrid.csv")

# Adding data to R
listings_madrid <- read.csv("data/listings_madrid.csv")
reviews_madrid <- read.csv("data/Reviews_Madrid.csv")

# Viewing the data
View(listings_madrid)
View(reviews_madrid)