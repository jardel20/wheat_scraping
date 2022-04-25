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

## Erros passíveis de ocorrerem

Com base no escopo do script e nos testes de desenvolvimento, nessa sessão, estamos incluindo informações dos erros passíveis de ocorrerem.

* **Timeout**[^6]: Acontece quando um servidor tenta carregar uma página web, mas não tem resposta de outro servidor que precisa acessar para completar o carregamento da página. Existem diversas possibilidades para o erro, como lentidão na comunicação, indisponibilidade do proxy ou da CDN etc. Algumas das mensagens comuns sobre esse tipo de falha são:  

	+ 504 Gateway Timeout;
	+ HTTP 504;
	+ 504 Error;
	+ Gateway Timeout (504);
	+ HTTP Error 504 — Gateway Timeout.
* **Conexão fechada pela outra ponta**: A conexão é fechada pelo site da revista em questão, impedindo que a extração de dados continue por parte do script.
* **Erro por conexão de internete fraca**: *"Error in open.connection(x, "rb"): Failed to connect to link.springer.com port 443 after 9033 ms: Não há rota para o host".* Esse erro ocorre na função `rvest::read_html()`.

[^6]: https://rockcontent.com/br/blog/504-gateway-timeout/

* **Mudança de marcadores CSS e HTML das páginas de interesse:** Os marcadores dos elementos nas páginas alvo podem ser alterados ou outros iguais podem ser adicionados, sendo necessário remapear as páginas manualmente (no Firefox use <https://github.com/hermit-crab/ScrapeMate#readme> e no Google Chrome ou derivados use <https://selectorgadget.com/>) para atualizar os marcadores no código. 

## Dependências

Para esse projeto usamos algumas dependências:  

* **Dependêncas do R:** `{rvest}`[^3], `{pacman}`[^8], `{dplyr}`[^9], `{progress}`[^10], `{beepr}`[^11].

[^7]: https://rdocumentation.org/packages/rvest/versions/1.0.2
[^8]: https://www.rdocumentation.org/packages/pacman/versions/0.5.1
[^9]: https://www.rdocumentation.org/packages/dplyr/versions/0.7.8
[^10]: https://www.rdocumentation.org/packages/httr/versions/1.4.2/topics/progress
[^11]: https://www.rdocumentation.org/packages/beepr/versions/1.3/topics/beepr

* **Dependências de systema:** R version 4.1.3 [] ou superior

## Materiais de apoio

* Usando R: Um Guia para Cientistas Políticos: [Por Fernando Meireles - fmeireles@ufmg.br e Denisson Silva - denissonsilva@ufmg.br](https://electionsbr.com/livro/bases.html)  
* Introdução a Web Scraping com R: [Por Jodavid Ferreira ](https://estatidados.com.br/introducao-a-web-scraping-com-r/)  
* Estatística é com R!: [Por Prof. Dr. Steven Dutt Ross](http://www.estatisticacomr.uff.br/?p=869)  
* Scraping, Downloading, and Storing PDFs in R: [Por Samuel Workman](https://towardsdatascience.com/scraping-downloading-and-storing-pdfs-in-r-367a0a6d9199)  
* Web Crawling and Scraping using R: [Por Martin Schweinberger](https://slcladal.github.io/webcrawling.html)  
* Adding Images to Markdown Pages: [Por Marinegeo](https://marinegeo.github.io/2018-08-10-adding-images-markdown/)
* HTML `<img>` Tag: [Por w3schools](https://www.w3schools.com/tags/tag_img.asp)
* Web Scraping in R: rvest Tutorial: [Por Datacamp](https://www.datacamp.com/community/tutorials/r-web-scraping-rvest)
* Bar Progress: [Por github.com/r-lib/progress](https://github.com/r-lib/progress)
* Barra de progresso em R: [Por r-coder.com/progress-bar-r/](https://r-coder.com/progress-bar-r/)
* Códigos de status de respostas HTTP: [https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Status](https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Status)
