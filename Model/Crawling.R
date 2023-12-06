year <- c(1990:2019)
news <- list()

for (i in 1:length(year)) {
  base_url <- paste0('https://search.naver.com/search.naver?where=news&query=%EA%B0%80%EB%AD%84%2C%20%7C%20%ED%94%BC%ED%95%B4%2C%20%7C%20%EB%B0%9C%EC%83%9D%2C%20%7C%20%EC%A7%80%EC%97%AD%20%22%EA%B0%80%EB%AD%84%22%20%22%ED%94%BC%ED%95%B4%22%20%22%EC%A7%80%EC%97%AD%22%20%2B%EA%B0%80%EB%AD%84%20%2B%ED%94%BC%ED%95%B4%20%2B%EC%A7%80%EC%97%AD%20-%EC%83%88%ED%95%B4%20-%EC%9A%B4%EC%84%B8%20-4%EB%8C%80%EA%B0%95%20-%EC%99%B8%EA%B5%AD%20-%EC%A7%80%EA%B5%AC%EC%B4%8C&sm=tab_opt&sort=2&photo=0&field=0&reporter_article=&pd=3&ds=',year[i],'.01.01&de=',year[i],'.12.31&docid=&nso=so%3Ada%2Cp%3Afrom',year[i],'0101to',year[i],'1231%2Ca%3Aall&mynews=0&start=')
  html_l   <- paste0('https://search.naver.com/search.naver?where=news&query=%EA%B0%80%EB%AD%84%2C%20%7C%20%ED%94%BC%ED%95%B4%2C%20%7C%20%EB%B0%9C%EC%83%9D%2C%20%7C%20%EC%A7%80%EC%97%AD%20%22%EA%B0%80%EB%AD%84%22%20%22%ED%94%BC%ED%95%B4%22%20%22%EC%A7%80%EC%97%AD%22%20%2B%EA%B0%80%EB%AD%84%20%2B%ED%94%BC%ED%95%B4%20%2B%EC%A7%80%EC%97%AD%20-%EC%83%88%ED%95%B4%20-%EC%9A%B4%EC%84%B8%20-4%EB%8C%80%EA%B0%95%20-%EC%99%B8%EA%B5%AD%20-%EC%A7%80%EA%B5%AC%EC%B4%8C&sm=tab_opt&sort=2&photo=0&field=0&reporter_article=&pd=3&ds=',year[i],'.01.01&de=',year[i],'.12.31&docid=&nso=so%3Ada%2Cp%3Afrom',year[i],'0101to',year[i],'1231%2Ca%3Aall&mynews=0&start=1')
  
  html_c <- gsub(",","",html_l %>% read_html %>% html_nodes('div.section_head > div > span') %>% html_text %>% 
                   substr(8,html_l %>% read_html %>% html_nodes('div.section_head > div > span') %>% html_text %>% nchar-1)) %>% as.numeric
  
  cat(year[i], html_c, fill = T)
  ceiling(html_c/10) ## Page Number Count
  
  ### GET NEWS LINK ###
  urls <- NULL
  news_links <- NULL 
  for (x in 0:floor(html_c/10)){
    urls <- c(urls, paste(base_url, x*10+1,sep=''))  
    html_ex <- read_html(urls[x+1])
    news_links <- c(news_links, html_ex %>% html_nodes('ul.type01 > li > dl > dd > a') %>% html_attr('href'))
  }
  cat(year[i], html_c, length(news_links), fill = T)
  
  ### GET NEWS DATA ###
  Contents <- NULL
  Title <- NULL
  for (link in news_links) {
    html <- read_html(link)
    Contents <- c(Contents, html %>% html_node('._article_body_contents') %>% html_text()) %>% str_remove('flash 오류를 우회하기 위한 함수 추가\nfunction _flash_removeCallback()') %>% str_remove('동영상 뉴스')
    Title <- c(Title, html %>% html_nodes('#articleTitle') %>% html_text())
  } 
  
  Contents <- as.data.frame(Contents)
  title <- as.data.frame(Title)
  news[[i]] <- cbind(title, Contents)
}

