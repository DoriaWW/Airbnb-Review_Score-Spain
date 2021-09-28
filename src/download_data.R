library(googledrive)
library(haven)

# Create directory
dir.create("../data", showWarnings = FALSE)

## Downloading the data

downloads <- list(c(id = "11MaNZ2_XatX9OGZNkJnY9mWSPsZHuu3U",
                    city = 'barcelona'),
                  c(id = "1hSCeEx0FySiw2J8cEt6iAKDIoK",
                    city = 'girona'),
                  c(id = "1ftXX8qpWq0iXcAHN4SGzcY8BMWU0UrGV",
                    city = 'madrid'),
                  c(id = "11MaNZ2_XatX9OGZNkJnY9mWSPsZHuu3U",
                    city = 'barcelona')
)


for (file in downloads) {
  drive_download(as_id(file['id']), path = paste0('../data/listings_', file['city'], '.csv'), overwrite = TRUE)
  
}


if(0){
  data_id <-"10QZ9KuXmtIBdGUqv290vXY9ucTzrK8wR"
  out_file <- "data/listings_malaga.csv"
  drive_download(as_id(data_id), path = out_file, overwrite = TRUE)
  
  data_id <-"1K3FaAC5wBwm71IH31z7L87TCSS2HTImS"
  out_file <- "data/listings_menorca.csv"
  drive_download(as_id(data_id),  path = out_file, overwrite = TRUE)
  
  data_id <-"1zQmeH6kdUdXogeqQTb8avmkOA3BOgFG3"
  out_file <- "data/listings_sevilla.csv"
  drive_download(as_id(data_id), path = out_file, overwrite = TRUE)
  
  data_id <-"1AJzjZAgHqYsVQu2P9tsC-M-zWwJoA7p-"
  out_file <- "data/listings_valencia.csv"
  drive_download(as_id(data_id), path = out_file, overwrite = TRUE)
}

