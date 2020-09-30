# create directories for repository

dir.create("./data")
dir.create("./output")
dir.create("./output/figures/")
dir.create("./data/raw")
dir.create("./data/clean")
dir.create("./scripts")

# install packages
install.packages("tidyverse")
library(tidyverse)

# read in and save locally the time series data and lookup table

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

# merge the two datasets on common variables

# keep only parts of the Lookuptable that match 
library(dplyr)
merged_data <- merge(timeseries, lookuptable, by.x = c("Province/State", 
                                                       "Country/Region", 
                                                       "Lat","Long"), 
                   by.y = c("Province_State", "Country_Region", "Lat","Long_"),
                   all.x = TRUE, all.y = FALSE)

# tidy up order of columns
data_wide <- merged_data[,c(1,2,3,4,255:263,5:254)]

# save wide data 
saveRDS(data_wide, file = "./data/clean/data_wide.Rds")

# change into long format

#create data frame for use in tidyverse
data_2long <- data_frame(data_wide)
# pivot
data_long <- data_2long %>%
  pivot_longer(13:262, names_to = "date", values_to = "cases")

# save long data 
saveRDS(data_long, file = "./data/clean/data_long.Rds")

# CREATING GRAPHS
library(ggplot2)

# subset data to aggregate to a per country level, keeping population
subset <- subset(data_wide, select = -c(1, 3:12))

# aggregate by country ignoring missings in population
countrydata <- subset %>% 
  group_by(`Country/Region`) %>%
  summarise_each(funs(sum(., na.rm = TRUE)))

# convert to long format for graphing
countrydata <- countrydata %>%
  pivot_longer(3:252, names_to = "date", values_to = "cases")         

# convert format of the date
countrydata <- mutate(countrydata, date = as.Date(date, "%m/%d/%Y"))

# subset and aggregate for graph 1
graph1 <- subset(countrydata, select = -c(2))

# Graph 1 overall
graph1 %>% group_by(date) %>%
  summarise(Totalcases = sum(cases)) %>%
  ggplot(aes(x = date, y = Totalcases)) + geom_line() +
  scale_y_continuous(trans = 'log2') +
  scale_x_date(date_breaks = "1 month", date_labels = "%b") +
  labs (
    title = "Overall change in time, log number of COVID-19 cases, 2000",
    caption = "Source: John Hopkins Data repository ",
    subtitle = "World-wide",
    x = "Month in 2020",
    y = "Log cases")

ggsave("output/figures/totalcasesovertime.png")

# graph 2 on a per country basis

# data for countries of population >200 million
graph2a <- countrydata[ which(countrydata$Population > 90000000), ]

# data for countries of population < 100000
graph2b <- countrydata[ which(countrydata$Population < 250000), ]

# plot countries with >90 million population
graph2a %>%
  ggplot(aes(x = date, y= cases)) + 
  geom_line() + 
  scale_y_continuous(trans = 'log2') +
  scale_x_date(date_breaks = "1 month", date_labels = "%b") +
  facet_wrap(~ `Country/Region`, nrow = 5) +
  labs (
    title = "Change in time, log number of COVID-19 cases, 2000",
    caption = "Source: John Hopkins Data repository ",
    subtitle = "Countries/Regions of highest population",
    x = "Month in 2020",
    y = "Log cases")

ggsave("output/figures/highpop.png")

# plot countries with <250000 population
graph2b %>%
  ggplot(aes(x = date, y= cases)) + 
  geom_line() + 
  scale_y_continuous(trans = 'log2') +
  scale_x_date(date_breaks = "1 month", date_labels = "%b") +
  facet_wrap(~ `Country/Region`, nrow = 5) +
  labs (
  title = "Change in time, log number of COVID-19 cases, 2000",
  caption = "Source: John Hopkins Data repository ",
  subtitle = "Countries/Regions of lowest population",
  x = "Month in 2020",
  y = "Log cases")

ggsave("output/figures/lowpop.png")

# Final graphs on rate of infection

# create column for rate of infection
graph3a <- graph2a %>%
  mutate(rate_of_infection = cases/Population * 100000)

graph3b <- graph2b %>%
  mutate(rate_of_infection = cases/Population * 100000)

# plot countries with >90 million population
graph3a %>%
  ggplot(aes(x = date, y= rate_of_infection)) + 
  geom_line() + 
  scale_x_date(date_breaks = "1 month", date_labels = "%b") +
  facet_wrap(~ `Country/Region`, nrow = 5) +
  labs (
    title = "Change in time, rate of infection of COVID-19 cases, 2000",
    caption = "Source: John Hopkins Data repository ",
    subtitle = "Countries/Regions of highest population",
    x = "Month in 2020",
    y = "Rate of infection per 100000")

ggsave("output/figures/ratehighpop.png")

# plot countries with <250000 population
graph3b %>%
  ggplot(aes(x = date, y= rate_of_infection)) + 
  geom_line() + 
  scale_x_date(date_breaks = "1 month", date_labels = "%b") +
  facet_wrap(~ `Country/Region`, nrow = 5) +
  labs (
    title = "Change in time, rate of infection of COVID-19 cases, 2000",
    caption = "Source: John Hopkins Data repository ",
    subtitle = "Countries/Regions of lowest population",
    x = "Month in 2020",
    y = "Rate of infection per 100000")

ggsave("output/figures/ratelowpop.png")

