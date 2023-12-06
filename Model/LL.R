## Load data
df <- data.frame(drought_impact, drought_index)

md <- glm(drought_impact ~ drought_index, df, family = 'binomial')
pd <- predict(md, list(drought_index=x), type="response")

## Calculate auc value
auc <- predict(md, df, type="response") %>% prediction(df$drought_impact) %>% performance(measure="auc")
print(auc@y.values[[1]] %>% round(4)) 

## Calculate the ROC curve
predict(md, df, type="response") %>% prediction(df$drought_impact) %>% performance(measure="tpr", x.measure = "fpr")
