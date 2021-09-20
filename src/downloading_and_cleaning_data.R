# Download data
dir.create(("data"), showWarnings = FALSE)
download.file("http://data.insideairbnb.com/spain/catalonia/barcelona/2021-07-07/data/listings.csv.gz", "data/listings_barcelona.csv")
download.file("http://data.insideairbnb.com/spain/catalonia/girona/2021-07-22/data/listings.csv.gz", "data/listings_girona.csv")
download.file("http://data.insideairbnb.com/spain/comunidad-de-madrid/madrid/2021-07-07/data/listings.csv.gz", "data/listings_madrid.csv")
download.file("http://data.insideairbnb.com/spain/andaluc%C3%ADa/malaga/2021-07-23/data/listings.csv.gz", "data/listings_malaga.csv")
download.file("http://data.insideairbnb.com/spain/islas-baleares/menorca/2021-07-23/data/listings.csv.gz", "data/listings_menorca.csv")
download.file("http://data.insideairbnb.com/spain/andaluc%C3%ADa/sevilla/2021-07-22/data/listings.csv.gz", "data/listings_sevilla.csv")
download.file("http://data.insideairbnb.com/spain/vc/valencia/2021-07-13/data/listings.csv.gz", "data/listings_valencia.csv")

# Add data into R
listings_barcelona <- read.csv("data/listings_barcelona.csv")
listings_girona <- read.csv("data/listings_girona.csv")
listings_madrid <- read.csv("data/listings_madrid.csv")
listings_malaga <- read.csv("data/listings_malaga.csv")
listings_menorca <- read.csv("data/listings_menorca.csv")
listings_sevilla <- read.csv("data/listings_sevilla.csv")
listings_valencia <- read.csv("data/listings_valencia.csv")

# Add column with city
listings_barcelona$city <- "Barcelona"
listings_girona$city <- "Girona"
listings_madrid$city <- "Madrid"
listings_malaga$city <- "Malaga"
listings_menorca$city <- "Menorca"
listings_sevilla$city <- "Sevilla"
listings_valencia$city <- "Valencia"

# Adding dummy variable for city size small/medium/big
listings_barcelona$size_small <- 0
listings_barcelona$size_medium <- 0
listings_barcelona$size_large <- 1
listings_girona$size_small <- 1
listings_girona$size_medium <- 0
listings_girona$size_large <- 0
listings_madrid$size_small <- 0
listings_madrid$size_medium <- 0
listings_madrid$size_large <- 1
listings_malaga$size_small <- 0
listings_malaga$size_medium <- 1
listings_malaga$size_large <- 0
listings_menorca$size_small <- 1
listings_menorca$size_medium <- 0
listings_menorca$size_large <- 0
listings_sevilla$size_small <- 0
listings_sevilla$size_medium <- 1
listings_sevilla$size_large <- 0
listings_valencia$size_small <- 0
listings_valencia$size_medium <- 1
listings_valencia$size_large <- 0

# Creating a data frame
listings_barcelona <- listings_barcelona %>% select(18, 33, 56, 61:67, 75:78)
listings_girona <- listings_girona %>% select(18, 33, 56, 61:67, 75:78)
listings_madrid <- listings_madrid %>% select(18, 33, 56, 61:67, 75:78)
listings_malaga <- listings_malaga %>% select(18, 33, 56, 61:67, 75:78)
listings_menorca <- listings_menorca %>% select(18, 33, 56, 61:67, 75:78)
listings_sevilla <- listings_sevilla %>% select(18, 33, 56, 61:67, 75:78)
listings_valencia <- listings_valencia %>% select(18, 33, 56, 61:67, 75:78)

# Deleting missing values
listings_barcelona <- na.omit(listings_barcelona)
listings_girona <- na.omit(listings_girona)
listings_madrid <- na.omit(listings_madrid)
listings_malaga <- na.omit(listings_malaga)
listings_menorca <- na.omit(listings_menorca)
listings_sevilla <- na.omit(listings_sevilla)
listings_valencia <- na.omit(listings_valencia)