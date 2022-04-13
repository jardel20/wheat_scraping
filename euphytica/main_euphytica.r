###############################################
#######         Euphytica Module        #######
#######                                 #######
####### Author: Jardel de Moura Fialho  #######
####### Project: Web Scraping           #######
###############################################

Sys.setenv("http_proxy"="")
Sys.setenv("no_proxy"=TRUE)
Sys.setenv("no_proxy"=1)

base::print("Rodando...") # indica que o script comecou
base::rm(list = base::ls()) # limpa as variaveis de ambiente

# installing and loading packages if necessary ####
if (!require(dplyr)){ 
  utils::install.packages("dplyr") # se nao carregar, instale e carregue
  library(dplyr)
}
if (!require(rvest)){
  utils::install.packages("rvest")
  library(rvest)
}
if (!require(progress)){
  utils::install.packages("progress")
  library(progress)
}
if (!require(beepr)) {
  utils::install.packages("beepr")
  library(beepr)
}

################################################################################

# link principal ####
next_link <- "https://link.springer.com/search?query=wheat&search-within=Journal&facet-journal-id=10681"

#num_pag guarda o numero de paginas que existem no site
num_pag <- rvest::read_html(next_link) %>% # converter um site em um objeto XML
  rvest::html_nodes(".functions-bar-top .number-of-pages") %>% # extrair os nos relevantes do objeto XML
  rvest::html_text() %>% # extrair os dados marcados
  base::as.integer() # transforma o "character" para "integer"

#cria a barra de progresso
pb <- progress_bar$new(format = ":current/:total [:bar] (:percent)", 
                       total = 5,
                       complete = "#",
                       incomplete = ".",
                       current = "#",
                       clear = FALSE)

# dataframe para acumular e guardar futuros resultados do loop for
df2 <- base::data.frame()

################################################################################

# functions ####

#obtem os links de downaload dos artigos
get_download_link <- function(name_link) { # funcao pra coletar os XML de cada artigo
  articles_page <- rvest::read_html(name_link) # converter um site em um objeto XML

  link_download_citation <- articles_page %>%
    rvest::html_nodes("#article-info-content a") %>% # extrair os nos relevantes do objeto XML
    rvest::html_attr("href") # extrair os atributos
}

################################################################################

# get informations ####

for (pages in 1:5) { # loop para coletar informacoes de todas as paginas
  
  pb$tick(0)
  
  euphytica <- rvest::read_html(x = next_link, encoding = "UTF-8")

  # step1 (at articles)
  name <- euphytica %>%
    rvest::html_nodes("#results-list .title") %>%
    rvest::html_text()
  name_url <- euphytica %>%
    rvest::html_nodes("#results-list .title") %>%
    rvest::html_attr("href") %>%
    base::paste0("https://link.springer.com", .) # une parte do link extraido como  principal
  authors <- euphytica %>%
    rvest::html_nodes(".meta") %>%
    rvest::html_text2()
  type <- euphytica %>%
    rvest::html_nodes(".content-type") %>%
    rvest::html_text2()
  description <- euphytica %>%
    rvest::html_nodes(".snippet") %>%
    rvest::html_text()
  
  df1 <- base::data.frame(name, name_url, authors, type, description)
  
  # step2 (in articles)
  # coleta as informacoes de dentro de cada artigo usando a funcao get_download_link
  download_articles <- base::sapply(name_url, 
                                    FUN = get_download_link, 
                                    USE.NAMES = F)

  # junta o dataframe df com as informacoes anteriormente coletadas
  df2 <- base::rbind(df2, df1)

  # responsavel por informar ao loop novamente o endereco correto da proxima pagina
  next_link <- euphytica %>%
    rvest::html_nodes(".next") %>%
    rvest::html_attr("href") %>%
    base::paste0("https://link.springer.com", .)

  next_link <- next_link[1] # coleta apenas um dos links duplicados da proxima pagina
}

print("Exportando dados...")
Sys.sleep(1)

# export dataset ####
utils::write.csv2(x = df, file = "/home/jardel/MEGA/scripts-pessoais/RScripts/wheat_scraping/euphytica/euphytica_dataset.csv")
base::saveRDS(object = df, file = "/home/jardel/MEGA/scripts-pessoais/RScripts/wheat_scraping/euphytica/euphytica_dataset.RData")

print("Concluído!")