####Install Packages####
install.packages(c('multilinguer','stringr', 'hash','tau','Sejong','RSQLite','devtools','rJava',
                   'remote','dplyr','tidyverse','tidytext','backports','wordcloud','readxl','ggplot2',
                   'sp','maptools','mapproj','lubridate','viridis','xlsx'), type ="binary")
install.packages(c('fields','openair','chron','actuar','zoo','akima','reshape2','automap','ggmap',
                   'sf','rgdal','cowplot','viridisLite','R.matlab','ncdf4','SPEI'), type ="binary")
install.packages(c('tidyverse','tidytext','wordcloud','wordcloud2','ggExtra','rgeos'), type ="binary")
install.packages("remotes")
install_jdk()
Sys.setenv(JAVA_HOME='write your installed java path')
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

#Load Pacakages
library(KoNLP);library(rvest);library(NIADic);library(Sejong);library(wordcloud);library(wordcloud2);library(tau);library(hash)
library(rJava);library(rgdal);library(RSQLite);library(devtools)
library(dplyr);library(cowplot);library(ggExtra);library(lubridate);library(zoo);library(chron);library(readxl);library(reshape2);library(xlsx)
library(raster);library(ggmap);library(rgeos);library(maptools);library(maps);library(mapdata);library(automap);library(mapproj);library(fields)
library(multilinguer);library(tidyverse);library(tidytext);library(sf);library(backports);library(akima);library(ggrepel);library(rnaturalearth)
library(viridis);library(R.matlab);library(ncdf4);library(SPEI);library(actuar);library(openair);library(rnaturalearthdata);library(ggspatial)
library(caret);library(randomForest);library(e1071);library(xgboost);library(ROCR, warn.conflicts = F)
library(stringr)
buildDictionary(ext_dic = "woorimalsam")  # load korean language pack
useNIADic() 
