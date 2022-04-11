#########################################
#### Euphytica Module                ####
#### Author: Jardel de Moura Fialho  ####
#########################################

base::print("Rodando...")
base::rm(list = base::ls())

# installing and loading packages if necessary ####
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)  
if(!require(rvest)) install.packages("rvest")
library(rvest)  

# functions ####
get_download_link <- function(name_link) {
  articles_page <- rvest::read_html(name_link)

  link_download_citation <- articles_page %>%
    rvest::html_nodes("#article-info-content a") %>%
    rvest::html_attr("href")
}
# get <- function(name_link) {####
# articles_page <- rvest::read_html(name_link)

# published <- articles_page %>%
# rvest::html_nodes("time") %>%
# rvest::html_text()
# accesses <- articles_page %>%
# rvest::html_nodes(".c-article-metrics-bar__count") %>%
# rvest::html_text()

# get informations ####
next_link <- "https://link.springer.com/search?query=wheat&search-within=Journal&facet-journal-id=10681"

df <- base::data.frame()

num_pag <- rvest::read_html(next_link) %>% 
  rvest::html_nodes(".functions-bar-top .number-of-pages") %>% 
  rvest::html_text() %>% 
  base::as.integer()

for (pages in 1:num_pag) {
  
  euphytica <- rvest::read_html(x = next_link, encoding = "UTF-8")
  
  # step1 (at articles)
  name <- euphytica %>%
    rvest::html_nodes("#results-list .title") %>%
    rvest::html_text()
  name_url <- euphytica %>%
    rvest::html_nodes("#results-list .title") %>%
    rvest::html_attr("href") %>%
    base::paste("https://link.springer.com", ., sep = "")
  authors <- euphytica %>%
    rvest::html_nodes(".meta") %>%
    rvest::html_text2()
  type <- euphytica %>%
    rvest::html_nodes(".content-type") %>%
    rvest::html_text2()
  description <- euphytica %>%
    rvest::html_nodes(".snippet") %>%
    rvest::html_text()
  
  # step2 (in articles)
  articles <- base::sapply(name_url, 
                           FUN = get_download_link, 
                           USE.NAMES = F)

  df <- base::rbind(df, base::data.frame(name,
                                         name_url, 
                                         authors, 
                                         type, 
                                         description))

  next_link <- euphytica %>%
    rvest::html_nodes(".next") %>%
    rvest::html_attr("href") %>%
    base::paste("https://link.springer.com", ., sep = "")
    
  next_link <- next_link[1]
  
  base::print(base::paste(pages, "de", num_pag))
}

# export dataset ####
base::saveRDS(object = df, file = "euphytica_dataset.RData")

'directory <- system(command = "pwd")

base::saveRDS(object = df, file = paste(directory, "euphytica_dataset.RData"))
utils::write.csv(x = df, file = paste(directory, "euphytica_dataset.RData"))

base::print("Arquivos .RData e .csv salvos com sucesso!")'