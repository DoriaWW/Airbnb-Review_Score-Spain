all: output/Overview of rating scores.jpg output/size_descriptives.RDS output/room_type_descriptives.RDS output/superhost_descriptives.RDS output/table_descriptives.RDS

data/combined.csv: src/download_data.R
		R --vanilla < src/download_data.R
		
	
temp/listings_all.csv: src/clean_data.R data/combined.csv
		R --vanilla <src/clean_data.R	


src/analysis.R: src/analysis.R src/clean_data temp/listings_all.csv
		R --vanilla <src/analysis.R
		







			
	