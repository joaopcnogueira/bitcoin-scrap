library(dplyr)
library(sessioninfo)
library(readr)

package_info() %>% 
  as_tibble() %>% 
  filter(attached) %>% 
  select(package, loadedversion) %>% 
  writeRDS(path = "requirements.rds")


map2(packages, versions, install_version(package = .x, version = .y))
