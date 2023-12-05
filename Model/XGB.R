## Load data
df <- data.frame(drought_impact, drought_index)

## Parameter tuning
set.seed(1)
pr <- list(booster = 'gbtree', objective="binary:logistic", max_depth = 2, verbose = 0)
xgbcv <- xgb.cv(pr,data = xgb.DMatrix(data = data.matrix(df), label = df$drought_impact), 
                nrounds = 200, nfold = 10, showsd = T, stratified = T, maximize = F)

xgbcv$evaluation_log$test_logloss_mean # Calculate logloss

md = seq(2, 10, by=3)
conv_md = matrix(NA, 200, length(md))
for (t in 1:length(md)){
    set.seed(100)
    pr <- list(booster = 'gbtree', objective="binary:logistic", max_depth = md[t], verbose = 0)
    
    rt <- xgb.cv(pr,data = xgb.DMatrix(data = data.matrix(df), 
                                       label = df$drought_impact), nrounds = 200, nfold = 10)
    conv_md[,t] = rt$evaluation_log$train_logloss_mean
  }
  
conv_md=data.frame(iter=1:200,conv_md)


## Modelling
set.seed(1) ## set the seed number
md_xg <- xgboost(data = xgb.DMatrix(data = data.matrix(df), label = df$drought_impact), booster='gbtree',
                 nrounds = 200, objective="binary:logistic", verbose=0, max_depth = 2, eval_matric = "auc")
predict(md_xg, xgb.DMatrix(data = data.matrix(df), label = df$drought_impact))

## Calculate auc value
auc <- predict(md_xg, xgb.DMatrix(data = data.matrix(df), label = df$drought_impact), type="response") %>% prediction(df$drought_impact) %>% performance(measure="auc")
print(auc@y.values[[1]] %>% round(4)) 

## Calculate the ROC curve
predict(md_xg, xgb.DMatrix(data = data.matrix(df), label = df$drought_impact), type="response") %>% prediction(df$drought_impact) %>% performance(measure="sens", x.measure = "fpr")
