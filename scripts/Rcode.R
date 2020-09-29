dir.create("./data")
dir.create("./output")
dir.create("./output/fig")
dir.create("./data/raw")
dir.create("./data/clean")
dir.create("./scripts")

install.packages("tidyverse")
library(tidyverse)

# read in and save locally the time eries data
timeseries <- read_csv(paste("https://github.com/CSSEGISandData/COVID-19/blob",
                             "/master/csse_covid_19_data/csse_covid_19_time_",
                             "series/time_series_covid19_confirmed_global.csv?",
                             "raw==true", sep = ""))
saveRDS(timeseries, file = "./data/raw/timeseries.Rds")

lookuptable <- read_csv(paste("https://github.com/CSSEGISandData/COVID-19/blob",
                        "/master/csse_covid_19_data",
                        "/UID_ISO_FIPS_LookUp_Table.csv?",
                        "raw==true", sep = ""))
saveRDS(lookuptable, file = "./data/raw/lookuptable.Rds")

# merge the two datasets on latitude and longitude
# keep only relevant parts of the Lookuptable
library(dplyr)
merged_data <- merge(timeseries, lookuptable, by.x = c("Province/State", "Country/Region", "Lat","Long"), 
                   by.y = c("Province_State", "Country_Region", "Lat","Long_"), all.x = TRUE, all.y = FALSE)
# tidy up order of columns
data_wide <- merged_data[,c(1,2,3,4,255:262,5:254)]

# save wide data 
saveRDS(data_wide, file = "./data/clean/data_wide.Rds")

# change into long format
#create data frame
data_2long <- data_frame(data_wide)
# pivot
data_long <- data_2long %>%
  pivot_longer(13:262, names_to = "date", values_to = "cases")

# save long data 
saveRDS(data_long, file = "./data/clean/data_long.Rds")

