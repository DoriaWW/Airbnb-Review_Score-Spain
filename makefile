all: analysis clean_data data

analysis:src/analysis.R clean_data
		R --vanilla <src/analysis.R



clean_data:src/clean_data.R data
		R --vanilla <src/clean_data.R	



data:src/download_data.R
		R --vanilla < src/download_data.R
			
	