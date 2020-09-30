# Examining COVID-19 cases numbers across time

**This is my first project for Modern Workflows in Data Science**

## Project Description

Examination of the number of COVID-19 cases worldwide and rate of infection, with a focus on countries/regions with either very high or very low population.

Data used in this work has been obtained from the COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University 
(url: https://github.com/CSSEGISandData/COVID-19.)

## Repository organisation

data/clean : Clean data in long and wide format
output/figures: Figures used in this report 
scripts: R scripts used for data download, cleaning, and creation of figures
mwf_assignment1.Rproject : The R project 
README.md : all this important stuff

## Main Findings

**Overall**

The change in the number of cases worldwide is shown in the graph below on a log scale.  The growth is fastest between January and mid-February and March and mid-April.

![](output/figures/totalcasesovertime.png?raw=true "Total cases overtime")

**Counts for the Most Highly Populated, and Lowest Populated Countries/Regions** 

The graph below shows the growth in COVID-19 cases for countries/regions with a population greater than 90 million.  In all countries the log number of cases by October is very high.  A number of countries manage to keep numbers low up until March.

![](output/figures/highpop.png?raw=true "High population countries")

The graph below shows the growth in COVID-19 cases for Countries/Regions with a population of less than 250000.  While the actual number of cases is comparatively lower then for the most highly populated countries, the pattern of growth is not too dissimilar.  The fastest growth is mostly from April which is more delayed then the more highly populated countries.  

![](output/figures/lowpop.png?raw=true "Low population countries")

**Rate of Infection for the Most Highly Populated, and Lowest Populated Countries/Regions** 

Examining the rate of infection per 100,000 cases allows to us take population into account and make more even comparisons.  The graphs below so the rate of infection in the same most highly populated countries/regions and the lowest populated countries/regions.  The graphs demonstrate that high population does not mean the highest rate of infection.  Small countries/regions like San Marino, the Holy see and Andorra have similar rates of infections to large countries Brazil, and the US.  And Diamond Princess (the cruise ship) takes the prize.

![](output/figures/ratehighpop.png?raw=true "Rate in high population countries")

![](output/figures/ratehighpop.png?raw=true "Rate in low population countries")

# Session information

R version 4.0.2 (2020-06-22)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 18363)

Matrix products: default

locale:
[1] LC_COLLATE=English_Australia.1252  LC_CTYPE=English_Australia.1252   
[3] LC_MONETARY=English_Australia.1252 LC_NUMERIC=C                      
[5] LC_TIME=English_Australia.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] forcats_0.5.0   stringr_1.4.0   dplyr_1.0.2     purrr_0.3.4     readr_1.3.1     tidyr_1.1.2    
[7] tibble_3.0.3    ggplot2_3.3.2   tidyverse_1.3.0

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.5       cellranger_1.1.0 pillar_1.4.6     compiler_4.0.2   dbplyr_1.4.4    
 [6] tools_4.0.2      digest_0.6.25    jsonlite_1.7.1   lubridate_1.7.9  lifecycle_0.2.0 
[11] gtable_0.3.0     pkgconfig_2.0.3  rlang_0.4.7      reprex_0.3.0     cli_2.0.2       
[16] DBI_1.1.0        rstudioapi_0.11  curl_4.3         haven_2.3.1      xfun_0.17       
[21] withr_2.3.0      xml2_1.3.2       httr_1.4.2       fs_1.5.0         generics_0.0.2  
[26] vctrs_0.3.4      hms_0.5.3        grid_4.0.2       tidyselect_1.1.0 glue_1.4.2      
[31] R6_2.4.1         fansi_0.4.1      readxl_1.3.1     farver_2.0.3     modelr_0.1.8    
[36] blob_1.2.1       magrittr_1.5     backports_1.1.10 scales_1.1.1     ellipsis_0.3.1  
[41] rvest_0.3.6      assertthat_0.2.1 colorspace_1.4-1 labeling_0.3     tinytex_0.26    
[46] stringi_1.5.3    munsell_0.5.0    broom_0.7.0      crayon_1.3.4   
