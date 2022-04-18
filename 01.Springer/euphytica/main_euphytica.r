###############################################
#######         Euphytica Module        #######
#######                                 #######
####### Author: Jardel de Moura Fialho  #######
####### Project: Web Scraping           #######
###############################################

base::print("Rodando...") #indicates that the script has started

base::Sys.setenv("http_proxy"="")
base::Sys.setenv("no_proxy"=TRUE)
base::Sys.setenv("no_proxy"=1) #prevent proxy problems

base::rm(list = base::ls()) #clear environment variables

# installing and loading packages if necessary ####
if (!base::require(pacman)) utils::install.packages("pacman") #if it doesn't load, install and load
base::library(pacman)

pacman::p_load(dplyr, rvest, progress, beepr, tcltk)
################################################################################

# main link ####
next_link <- "https://link.springer.com/search?query=wheat&search-within=Journal&facet-journal-id=10681"

#num_pag saves the number of pages that exist on the site
num_pag <- rvest::read_html(next_link) %>% # converter um site em um objeto XML
  rvest::html_nodes(".functions-bar-top .number-of-pages") %>% # extrair os nos relevantes do objeto XML
  rvest::html_text() %>% # extrair os dados marcados
  base::as.integer() # transforma o "character" para "integer"

#create the progress bar
pb <- progress_bar$new(format = ":current/:total [:bar] (:percent)", 
                       total = 5,
                       complete = "#",
                       incomplete = ".",
                       current = "#",
                       clear = FALSE)

df1 <- base::data.frame() #define a clean dataframe
################################################################################

# functions ####

#get the article download links
get_download_link <- function(name_link) { # funcao pra coletar os XML de cada artigo

  articles_page <- rvest::read_html(name_link) # converter um site em um objeto XML
  
  link_download_citation <- articles_page %>%
    rvest::html_nodes("#article-info-content a") %>% # extrair os nos relevantes do objeto XML
    rvest::html_attr("href") # extrair os atributos
}
################################################################################

# get informations ####

for (pages in 1:5) { # loop para coletar informacoes de todas as paginas
  
  pb$tick()
  
  euphytica <- rvest::read_html(x = next_link, encoding = "UTF-8")
  
  #step1 (at articles)
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
  
  #step2 (in articles)
  #collects the information from within each article using the get_download_link function

  download_articles <- base::sapply(name_url, 
                                    FUN = get_download_link, 
                                    USE.NAMES = F)
  
  df1 <- base::data.frame(name, name_url, authors, type, description, download_articles)
  
  #joins the df data.frame with the previously collected information
  df2 <- base::rbind(df2, df1)

  #responsible for informing the loop again the correct address of the next page
  next_link <- euphytica %>%
    rvest::html_nodes(".next") %>%
    rvest::html_attr("href") %>%
    base::paste0("https://link.springer.com", .)
  
  next_link <- next_link[1] # coleta apenas um dos links duplicados da proxima pagina
}

base::print("Exportando dados...")
base::Sys.sleep(1)

# export dataset ####
utils::write.csv2(x = df2, file = "/home/jardel/MEGA/scripts-pessoais/RScripts/wheat_scraping/euphytica/euphytica_dataset.csv")
base::saveRDS(object = df2, file = "/home/jardel/MEGA/scripts-pessoais/RScripts/wheat_scraping/euphytica/euphytica_dataset.RData")

base::print("Concluído!")
base::Sys.sleep(1)
beepr::beep("facebook")

