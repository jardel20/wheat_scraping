Sys.setenv("http_proxy"="")
Sys.setenv("no_proxy"=TRUE)
Sys.setenv("no_proxy"=1)

base::print("Rodando...") 
base::rm(list = base::ls()) 


if (!require(dplyr)) utils::install.packages("dplyr") 
library(dplyr)
if (!require(rvest)) utils::install.packages("rvest")
library(rvest)
if (!require(progress)) utils::install.packages("progress")
library(progress)
if (!require(beepr)) utils::install.packages("beepr")
library(beepr)

################################################################################

next_link <- "https://link.springer.com/search?query=wheat&search-within=Journal&facet-journal-id=10681"

# get informations ####
num_pag <- rvest::read_html(next_link) %>% 
	rvest::html_nodes(".functions-bar-top .number-of-pages") %>% 
	rvest::html_text() %>% 
	base::as.integer() 

pb <- progress_bar$new(format = ":current/:total [:bar] (:percent)", 
			     total = 3,
			     complete = "#",
			     incomplete = ".",
			     current = "#",
			     clear = FALSE)

df2 <- base::data.frame()

################################################################################

# functions ####
#obtem os links de downaload dos artigos
get_download_link <- function(name_link) { 
	articles_page <- rvest::read_html(name_link) 
	
	link_download_citation <- articles_page %>%
		rvest::html_nodes("#article-info-content a") %>% 
		rvest::html_attr("href") 
}

#get_other_information <- function(name_link) {
'articles_page <- rvest::read_html(name_link)

  published <- articles_page %>%
  rvest::html_nodes("time") %>%
  rvest::html_text()
  accesses <- articles_page %>%
  rvest::html_nodes(".c-article-metrics-bar__count") %>%
  rvest::html_text()'

################################################################################

print("")

for (pages in 1:3) { 
	
	pb$tick()
	
	euphytica <- rvest::read_html(x = next_link, encoding = "UTF-8")
	
	# step1 (at articles)
	name <- euphytica %>%
		rvest::html_nodes("#results-list .title") %>%
		rvest::html_text()
	name_url <- euphytica %>%
		rvest::html_nodes("#results-list .title") %>%
		rvest::html_attr("href") %>%
		base::paste0("https://link.springer.com", .) 
	authors <- euphytica %>%
		rvest::html_nodes(".meta") %>%
		rvest::html_text2()
	type <- euphytica %>%
		rvest::html_nodes(".content-type") %>%
		rvest::html_text2()
	description <- euphytica %>%
		rvest::html_nodes(".snippet") %>%
		rvest::html_text()
	
	df1 <- base::data.frame(name,name_url,authors,type,description)
	
	# step2 (in articles)
	download_articles <- base::sapply(name_url,
						    FUN = get_download_link,
						    USE.NAMES = F)
	
	# junta o dataframe df com as informacoes anteriormente coletadas
	
	# O df ACUMULA MAIS LINHAS QUE O OUTRO data.frame || DEVIA ACUMULAR IGUAL
	df2 <- base::rbind(df2, df1)
	
	# responsavel por informar ao loop novamente o endereco correto da proxima pagina
	next_link <- euphytica %>%
		rvest::html_nodes(".next") %>%
		rvest::html_attr("href") %>%
		base::paste0("https://link.springer.com", .)
	
	next_link <- next_link[1] # coleta apenas um dos links duplicados da proxima pagina
}

beep("facebook") # Random notification
