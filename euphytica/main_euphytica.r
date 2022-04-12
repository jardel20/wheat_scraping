###############################################
#######         Euphytica Module        #######
####### Author: Jardel de Moura Fialho  #######
####### Project: Web Scraping           #######
###############################################

base::print("Rodando...") # indica que o script comecou 
base::rm(list = base::ls()) # limpa as variaveis de ambiente

# installing and loading packages if necessary ####
if(!require(dplyr)) install.packages("dplyr") # se nao carregar, instale e carregue
library(dplyr)  
if(!require(rvest)) install.packages("rvest")
library(rvest)  

# functions ####
get_download_link <- function(name_link) { # funcao pra coletar os XML de cada artigo
  articles_page <- rvest::read_html(name_link) # converter um site em um objeto XML

  link_download_citation <- articles_page %>%
    rvest::html_nodes("#article-info-content a") %>% # extrair os nos relevantes do objeto XML
    rvest::html_attr("href") # extrair os atributos
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

df <- base::data.frame() # dataframe para acumular e guardar futuros resultados do loop for

# num_pag guarda o numero de paginas que existem no site
num_pag <- rvest::read_html(next_link) %>% # converter um site em um objeto XML
  rvest::html_nodes(".functions-bar-top .number-of-pages") %>% # extrair os nos relevantes do objeto XML
  rvest::html_text() %>% # extrair os dados marcados
  base::as.integer() # transforma o "character" para "integer"

for (pages in 1:num_pag) { # loop para coletar informacoes de todas as paginas
  
  euphytica <- rvest::read_html(x = next_link, encoding = "UTF-8")
  
  # step1 (at articles)
  name <- euphytica %>%
    rvest::html_nodes("#results-list .title") %>%
    rvest::html_text()
  name_url <- euphytica %>%
    rvest::html_nodes("#results-list .title") %>%
    rvest::html_attr("href") %>%
    base::paste("https://link.springer.com", ., sep = "") # une parte do link extraido como  principal
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
  # coleta as informacoes de dentro de cada artigo usando a funcao get_download_link
  articles <- base::sapply(name_url,
                           FUN = get_download_link, 
                           USE.NAMES = F)
  
  # junta o dataframe df com as informacoes anteriormente coletadas
  df <- base::rbind(df, base::data.frame(name,
                                         name_url, 
                                         authors, 
                                         type, 
                                         description))
  
  # responsavel por informar ao loop novamente o endereco correto da proxima pagina
  next_link <- euphytica %>%
    rvest::html_nodes(".next") %>%
    rvest::html_attr("href") %>%
    base::paste("https://link.springer.com", ., sep = "")
    
  next_link <- next_link[1] # coleta apenas um dos links duplicados da proxima pagina
  
  base::print(base::paste(pages, "de", num_pag)) # mostra o progresso do loop
}

# export dataset ####
base::saveRDS(object = df, file = "euphytica_dataset.RData") # guarda o df em objeto RDS do R
