#Load the Meteorological data
PRCP <- read_excel("PR_station.xlsx") ; TMED <- read_excel("TP_station.xlsx")
latm <- read_excel("Site_info.xlsx")$lat

for (i in 1:length(latm$sn)) {
  data4pet<-cbind(year,month,PRCP,TMED,latm)
  datam <-as.data.frame(data4pet)

  datam$PET<-thornthwaite(datam$TMED,latm, na.rm = T)
  datam$PET[which(is.na(datam$PET))]<-0
  datam$PET[which(is.infinite(datam$PET))]<-0
  datam$PET[which(is.nan(datam$PET))]<-0
  
  data4spei<-cbind(year,month,datam$PET)
  D194605<-as.data.frame(data4spei)
  actspei<-spei(datam$PRCP-datam$PET,12,fit='ub-pwm', na.rm = T)
  tmspei<-as.numeric(actspei$fitted)
