#############################################################################
######################         euphytica Module        ######################
######################                                 ######################
###################### Author: Jardel de Moura Fialho  ######################
###################### Project: Web Scraping           ######################
#############################################################################

####################################### Header ######################################

base::cat("...Running euphytica Module...\n") #indicates that the script has started

#prevent proxy problems
base::Sys.setenv("http_proxy"="")
base::Sys.setenv("no_proxy"=TRUE)
base::Sys.setenv("no_proxy"=1) 

#clear environment variables
base::rm(list = base::ls()) 

# installing and loading packages if necessary ####
if (!base::require(pacman)) utils::install.packages("pacman") #if it doesn't load, install and load
base::library(pacman, verbose = FALSE); pacman::p_load(dplyr, rvest, progress, beepr)

################################ Declaring functions ################################

#main function get informations and save it in data.frame object
EuphyticaInformations <- function(link) {
  
  base::cat("...Starting data extraction...\n")
  
  #main link
  next_link <- link
  
  #get the article download links
  get_download_citation <- function(name_link) {
    
    articles_page <- rvest::read_html(name_link)
    
    link_download_citation <- articles_page %>%
      rvest::html_nodes(".c-bibliographic-information__download-citation a") %>%
      rvest::html_attr("href")
    return(link_download_citation)
  }
  
  get_download_articles <- function(name_link) {
    
    articles_page <- rvest::read_html(name_link)
    
    link_download_article <- articles_page %>% 
      rvest::html_nodes("#cobranding-and-download-availability-text a") %>% 
      rvest::html_attr("href") %>% 
      base::paste0("https://link.springer.com", .)
    return(link_download_article)
  }
  
  #num_pag saves the number of pages that exist on the site
  num_pag <- rvest::read_html(next_link) %>% # converter um site em um objeto XML
    rvest::html_nodes(".functions-bar-top .number-of-pages") %>% # extrair os nos relevantes do objeto XML
    rvest::html_text() %>% # extrair os dados marcados
    base::as.integer() # transforma o "character" para "integer"
  
  #create the progress bar
  pb <- progress_bar$new(format = "Progress :current/:total [:bar] :percent [Time: :elapsedfull]", 
                         total = 3,
                         complete = "=",
                         incomplete = " ",
                         current = ">",
                         clear = FALSE,)
  
  #define a clean dataframe
  df <- base::data.frame()
  
  for (pages in 1:3) { #loop to collect information within all available pages
    
    pb$tick()
    
    page_element <- rvest::read_html(x = next_link, encoding = "UTF-8")
    
    name <- page_element %>%
      rvest::html_nodes("#results-list .title") %>%
      rvest::html_text()
    name_url <- page_element %>%
      rvest::html_nodes("#results-list .title") %>%
      rvest::html_attr("href") %>%
      base::paste0("https://link.springer.com", .) # une parte do link extraido como o principal
    authors <- page_element %>%
      rvest::html_nodes(".meta") %>%
      rvest::html_text2()
    type <- page_element %>%
      rvest::html_nodes(".content-type") %>%
      rvest::html_text2()
    description <- page_element %>%
      rvest::html_nodes(".snippet") %>%
      rvest::html_text()
    
    #collects the information from within each article using the get_download_link function
    downloads_links_citation <- base::sapply(name_url,
                                             FUN = get_download_citation,
                                             USE.NAMES = FALSE)
    
    downloads_links_articles <- base::sapply(name_url,
                                             FUN = get_download_articles,
                                             USE.NAMES = FALSE)
    
    #joins the informations in variables
    df <- base::rbind(df, base::data.frame(name,
                                           name_url,
                                           authors,
                                           type,
                                           description,
                                           downloads_links_citation,
                                           downloads_links_articles,
                                           stringsAsFactors = FALSE))
    
    #responsible for informing the loop again the correct address of the next page
    next_link <- page_element %>%
      rvest::html_nodes(".next") %>%
      rvest::html_attr("href") %>%
      base::paste0("https://link.springer.com", .)
    
    #collects only one of the duplicate links from the next page
    next_link <- next_link[1]
  }; return(df)
}

#exports data in different formats
export_dataset <- function(df, directory) {
  
  base::cat("Exportando dados...\n")
  base::Sys.sleep(1)
  
  utils::write.csv2(x = df, file = paste0(directory, "euphytica.csv"))
  writexl::write_xlsx(x = df, path = paste0(directory ,"euphytica.xlsx"), col_names = TRUE)
  base::saveRDS(object = df, file = paste0(directory, "euphytica.RData"))
}

################################## Call functions ###################################

euphytica_dataset <- euphyticaInformations(link = "https://link.springer.com/search?query=wheat&search-within=Journal&facet-journal-id=10681")
export_dataset(df = euphytica_dataset, directory = "/home/jardel/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/exported_datasets/") 

################################## End script #######################################

base::Sys.sleep(1)
beepr::beep("facebook")
base::system(command = "notify-send -t 0 'The Euphytica module finished'") #especific command to Unix system
