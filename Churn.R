############################### Churn Analysis ###################################
#Dinesh Varma

#Installing Packages
library(tidyverse)
library(caret)
library(descr)
library(MASS)

#Reading Data
df<- read.csv(file="Churn.csv",header = T)
df$orderDate <- as.Date(df$orderDate,"%Y-%m-%d")
str(df)
summary(df)
table(df$returnCustomer)
prop.table(table(df$returnCustomer))

#Churn Rate
ggplot(data = df,aes(returnCustomer)) + geom_histogram(stat = "count")+labs(title = "Histogram of churn customer")

#Payment Method
ggplot(data = df,aes(df$paymentMethod)) + geom_bar(width = 0.3)

#Disply in proportions
ggplot(data = df,aes(df$paymentMethod)) + geom_bar(aes(y = ..prop..,group=1),width = 0.3)+ylim(0,1)

#Removing Unnecessary Fields if not removed in csv file
df$X <- NULL
df$ID <- NULL
df$orderDate <- NULL

#Data Partitioning
set.seed(111)
train.index <- createDataPartition(df$returnCustomer,p = 0.8,list = FALSE)
train.df <- df[train.index, ]
valid.df <- df[-train.index, ]

train.df$title <- relevel(train.df$title,ref = "Others")
train.df$paymentMethod <- relevel(train.df$paymentMethod,ref = "Current Account")

#Logistic Regression
logit.reg1 <- glm(returnCustomer ~ ., train.df,family = "binomial")
options(scipen = 999)

round(exp(coef(logit.reg1)),2)

AIC(logit.reg1)

#Choosing the Best fit model using stepAIC

logit.reg1.choose <- stepAIC(logit.reg1,trace = 0)
summary(logit.reg1.choose)
logit.reg1.choose['aic']
logit.reg1['aic']

#predict the model outcomes

logit.reg1.choose.pred <- predict(logit.reg1.choose,valid.df,type = "response")
t(t(head(logit.reg1.choose.pred,10)))

#Confusion Matrix
confusion.matrix <- table(valid.df$returnCustomer,logit.reg1.choose.pred >0.5)
confusion.matrix

#Model Accuracy
Accuracy <- sum(diag(confusion.matrix))/sum(confusion.matrix)
Accuracy

#knowing The Pay-off
payoff.matrix <- data.frame(thresold = seq(0.1,0.5,0.1),payoff=NA)
payoff.matrix

for(i in 1:length(payoff.matrix$thresold)){
  confusion.matrix <- table(valid.df$returnCustomer,logit.reg1.choose.pred>payoff.matrix$thresold[i])
  payoff.matrix$payoff[i] <- confusion.matrix[1,1]*120 + confusion.matrix[2,1]*(-600)
}

payoff.matrix






