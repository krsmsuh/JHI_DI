## Load Packages ##
install.packages(c('randomForest', 'dplyr'))
library(randomForest); library(dplyr)

## Load data
df <- data.frame(drought_impact, drought_index)

## Parameter tuning
set.seed(1)
tuneRF(drought_impact ~ drought_index, df, mtryStart = 2, stepFactor = 200, ntreeTry = 500, improve=0.0001, doBest = T, trace = F)

set.seed(1) ## set the seed number
md_rf <- randomForest(drought_impact ~ drought_index, df, mtry=2, ntree=50)

## Calculate auc value
auc <- predict(md_rf, df, type="response") %>% prediction(df$drought_impact) %>% performance(measure="auc")
print(auc@y.values[[1]] %>% round(4)) 

## Calculate the ROC curve
predict(md_rf, df, type="response") %>% prediction(df$drought_impact) %>% performance(measure="tpr", x.measure = "fpr")
