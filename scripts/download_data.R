library(data.table)
file_name <- 'dili_from_anti_TB_treatment.csv'
base_url <- 'http://data.bris.ac.uk/datasets/1vdt21e4mhxxd27hso89cqmhhh/'
local_dir <- 'data/original/'
local_path <- paste0(local_dir, file_name)
file_url <- paste0(base_url, file_name)
df <- fread(file_url)
save(df, file=local_path)
