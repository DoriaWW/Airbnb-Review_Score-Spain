OUTPUT = gen/output
TEMP = gen/temp

all: $(OUTPUT)/city_size_descriptives.RDS $(OUTPUT)/room_type_descriptives.RDS $(OUTPUT)/superhost_descriptives.RDS $(OUTPUT)/table_descriptives.RDS $(OUTPUT)/Overview_of_rating_scores.jpg $(OUTPUT)/regression.png

$(TEMP)/listings_all_raw.csv: src/download_data.R
		R --vanilla < src/download_data.R
		
$(TEMP)/listings_all.csv: src/clean_data.R $(TEMP)/listings_all_raw.csv
		R --vanilla < src/clean_data.R

$(OUTPUT)/city_size_descriptives.RDS $(OUTPUT)/room_type_descriptives.RDS $(OUTPUT)/superhost_descriptives.RDS $(OUTPUT)/table_descriptives.RDS: src/analysis_tables.R src/clean_data.R $(TEMP)/listings_all.csv
		R --vanilla < src/analysis_tables.R
		
$(OUTPUT)/Overview_of_rating_scores.jpg $(OUTPUT)/regression.png: src/analysis.plots_R $(TEMP)/listings_all.csv
		R --vanilla < src/analysis.plots_R
		
		