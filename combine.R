library(tidyverse)

filenames <- list.files('.')

filenames_csv <- filenames[str_detect(filenames, '.csv$')]

biomarkernames <- str_remove(filenames_csv, '.csv')

read_content <- function(filename, biomarkername){
  df <- read_csv(filename)
  df$biomarker <- biomarkername
  return (df)
}

df <- read_content('Albumin.csv', 'Albumin')

contents <- map2(filenames_csv, biomarkernames, read_content)

contents <- reduce(contents, bind_rows)

contents <- contents %>% 
  relocate(biomarker, .before = everything())

write_csv(contents, file = 'spiros_ukb_biomarkers_combined.csv')
