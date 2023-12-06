## Load data
df <- data.frame(drought_impact, drought_index)

## Parameter tuning
set.seed(1)
setnum <- tune.svm(drought_impact ~ drought_index, df, gamma=2^(-1:1), cost=2^(2:4))
md_sv <- svm(drought_impact ~ drought_index, df, kernel = "radial", gamma=setnum$best.parameters$gamma, cost=setnum$best.parameters$cost, epsilon=0.35)

## Calculate auc value
auc <- predict(md_sv, df, type="response") %>% prediction(df$drought_impact) %>% performance(measure="auc")
print(auc@y.values[[1]] %>% round(4)) 

## Calculate the ROC curve
predict(md_sv, df, type="response") %>% prediction(df$drought_impact) %>% performance(measure="sens", x.measure = "fpr")
