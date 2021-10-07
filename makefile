all: output/city_size_descriptives.RDS output/room_type_descriptives.RDS output/superhost_descriptives.RDS output/table_descriptives.RDS output/regression.png output/Overview of rating scores.jpg

temp/listings_all_raw.csv: src/download_data.R
		R --vanilla < src/download_data.R
		
temp/listings_all.csv: src/clean_data.R temp/listings_all_raw.csv
		R --vanilla < src/clean_data.R

output/city_size_descriptives.RDS output/room_type_descriptives.RDS output/superhost_descriptives.RDS output/table_descriptives.RDS output/regression.png output/Overview of rating scores.jpg: src/analysis.R src/clean_data.R temp/listings_all.csv
		R --vanilla < src/analysis.R