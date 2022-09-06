#Declare file location
here::i_am("2022-09-06-LEGO-Sets/dataLoader.R")

# Load packages
library(here)
library(tidyverse)

# Read in data
inventories <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-06/inventories.csv.gz')
inventory_sets <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-06/inventory_sets.csv.gz')
sets <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-06/sets.csv.gz')

# Join it all into one dataset to rule them all
all_df <- left_join(inventories, inventory_sets, by = "set_num") |>
  left_join(sets, by = "set_num")
