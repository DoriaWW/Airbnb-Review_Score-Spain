all: output/size_descriptives.RDS output/room_type_descriptives.RDS output/superhost_descriptives.RDS output/table_descriptives.RDS

temp/listings_all_raw.csv: src/download_data.R
		R --vanilla < src/download_data.R
		
temp/listings_all.csv: src/clean_data.R temp/listings_all_raw.csv
		R --vanilla < src/clean_data.R

output/size_descriptives.RDS output/room_type_descriptives.RDS output/superhost_descriptives.RDS output/table_descriptives.RDS: src/analysis.R src/clean_data.R temp/listings_all.csv
		R --vanilla < src/analysis.R