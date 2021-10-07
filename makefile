all: gen/output/city_size_descriptives.RDS gen/output/room_type_descriptives.RDS gen/output/superhost_descriptives.RDS gen/output/table_descriptives.RDS gen/output/Overview_of_rating_scores.jpg

gen/temp/listings_all_raw.csv: src/download_data.R
		R --vanilla < src/download_data.R
		
gen/temp/listings_all.csv: src/clean_data.R gen/temp/listings_all_raw.csv
		R --vanilla < src/clean_data.R

gen/output/city_size_descriptives.RDS gen/output/room_type_descriptives.RDS gen/output/superhost_descriptives.RDS gen/output/table_descriptives.RDS gen/output/Overview_of_rating_scores.jpg: src/analysis.R src/clean_data.R gen/temp/listings_all.csv
		R --vanilla < src/analysis.R

###### issue: gen/output/regression.png line 1 & 9