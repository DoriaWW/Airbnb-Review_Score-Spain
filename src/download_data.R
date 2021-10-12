## Setup
library(googledrive)

## Downloading the data
dir.create("data", showWarnings = FALSE)
downloads <- list(c(id = "11MaNZ2_XatX9OGZNkJnY9mWSPsZHuu3U", city = 'barcelona'),
                  c(id = "1hSCeEx0FySiw2J8cEt6iAKDIoK-7KDxN", city = 'girona'),
                  c(id = "1ftXX8qpWq0iXcAHN4SGzcY8BMWU0UrGV", city = 'madrid'),
                  c(id = "10QZ9KuXmtIBdGUqv290vXY9ucTzrK8wR", city = 'malaga'),
                  c(id = "1K3FaAC5wBwm71IH31z7L87TCSS2HTImS", city = 'menorca'),
                  c(id = "1zQmeH6kdUdXogeqQTb8avmkOA3BOgFG3", city = 'sevilla'),
                  c(id = "1AJzjZAgHqYsVQu2P9tsC-M-zWwJoA7p-", city = 'valencia')
)

for (file in downloads) {
  drive_download(as_id(file['id']), 
                 path = paste0('data/listings_', file['city'], '.csv'), overwrite = TRUE)
}

## Add data into R
all_files <- list.files('data', pattern = 'listings', full.names=T)
listings <- lapply(all_files, function(x) {
  print(x)
  df <- read.csv(x)
  df$filename = x
  return(df)
})

## Combining and saving the dataset
listings_all_raw = do.call('rbind', listings); rm(downloads); rm(file); rm(all_files); rm(listings)
dir.create("gen", showWarnings = FALSE)
dir.create("gen/temp", showWarnings = FALSE)
write.csv(listings_all_raw,"gen/temp/listings_all_raw.csv", row.names = FALSE); rm(listings_all_raw)