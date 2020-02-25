library(tidyverse)
library(lubridate)
library(rvest)


download_data <- function(cripto, end_date) {
  
  url <- str_glue("https://coinmarketcap.com/currencies/{cripto}/historical-data/?start=20130428&end={end_date}")
  
  data <- read_html(url) %>% 
    html_nodes("table") %>% 
    html_table() %>% 
    purrr::pluck(3) %>% 
    as_tibble() %>% 
    janitor::clean_names() %>% 
    mutate(date = mdy(date)) %>% 
    mutate_if(is.character, parse_number)

}


today <- today() %>% as.character
criptos <- c("bitcoin", "ethereum", "xrp", "litecoin", "eos")

data_tbl <- tibble(cripto = criptos) %>% 
  mutate(cripto_data = cripto %>% map(~download_data(cripto=.x, end_date=today))) %>% 
  unnest(cripto_data)

data_tbl %>% 
  write_rds("data/criptos_historical_data.rds")


