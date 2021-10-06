all: output/Overview of rating scores.jpg output/size_descriptives.RDS output/room_type_descriptives.RDS output/superhost_descriptives.RD output/table_descriptives.RD

data/combined.csv:src/download_data.R
		R --vanilla < src/download_data.R
		
	
output/listings_all.csv:src/clean_data.R data data/combined.csv
		R --vanilla <src/clean_data.R	


analysis:src/analysis.R clean_data output/listings_all.csv
		R --vanilla <src/analysis.R







			
	