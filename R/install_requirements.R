library(dplyr)
library(readr)
library(devtools)
library(purrr)

requirements <- read_rds("requirements.rds")
requirements

packages <- requirements %>% pull(package)
versions <- requirements %>% pull(loadedversion)

map2(packages, versions, ~install_version(package = .x, version = .y))
