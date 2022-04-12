# Wheat Scraping

Esse projeto se destina a usar a **Linguágem R**[^1] como protagonista no **web scraping**[^2] sobre dados de revistas científicas à respeito do trigo (*Triticum spp.*).

[^1]: https://cran.r-project.org/
[^2]: https://canaltech.com.br/seguranca/o-que-e-web-scraping/

Como principal pacote para essa tarefa, usamos o `{rvest}`[^3]. <img src="https://github.com/jardel20/wheat_scraping/blob/main/images/rvest_log.png" alt="rvest_icon" height="39px" width="30px" style="vertical-align:middle"/>

[^3]: https://cran.r-project.org/web/packages/rvest/index.html

## Como é extruturado

![fluxograma](https://github.com/jardel20/wheat_scraping/blob/main/images/Apresenta%C3%A7%C3%A3o%20sem%20t%C3%ADtulo.png?raw=true)

Em módulos (scripts.r), cada revista recebe um código personalizado para extração dos dados de interesse. Para tal, é preciso filtrar no site da revista por "wheat" para facilitar as buscas com os códigos.

Bases de revistas/sites usados:  
* Springer <img src="https://github.com/jardel20/wheat_scraping/blob/main/images/springer_icon.png" alt="springer_icon" height="30px" width="30px" style="vertical-align:middle"/>
	+ Euphytica: <https://link.springer.com/search?query=wheat&search-within=Journal&facet-journal-id=10681>
* Scopus
* Wiley
* SciELO

Por fim, um script executa em command line (CLI) ou com janelas gráficas um modo interativo para controlar os módulos. A lingágem a ser usada pode ser **Shell Script**[^4] ou outra lingúagem mais universal, como **Python**[^5].

[^4]: https://www.wikiwand.com/pt/Shell_script
[^5]: https://www.python.org/

## Material de apoio

* Usando R: Um Guia para Cientistas Políticos: [Por Fernando Meireles - fmeireles@ufmg.br e Denisson Silva - denissonsilva@ufmg.br](https://electionsbr.com/livro/bases.html)  
* Introdução a Web Scraping com R: [Por Jodavid Ferreira ](https://estatidados.com.br/introducao-a-web-scraping-com-r/)  
* Estatística é com R!: [Por Prof. Dr. Steven Dutt Ross](http://www.estatisticacomr.uff.br/?p=869)  
* Scraping, Downloading, and Storing PDFs in R: [Por Samuel Workman](https://towardsdatascience.com/scraping-downloading-and-storing-pdfs-in-r-367a0a6d9199)  
* Web Crawling and Scraping using R: [Por Martin Schweinberger](https://slcladal.github.io/webcrawling.html)  
* Adding Images to Markdown Pages: [Por Marinegeo](https://marinegeo.github.io/2018-08-10-adding-images-markdown/)
* HTML `<img>` Tag: [Por w3schools](https://www.w3schools.com/tags/tag_img.asp)
* Web Scraping in R: rvest Tutorial: [Por Datacamp](https://www.datacamp.com/community/tutorials/r-web-scraping-rvest)
