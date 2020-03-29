source('./preprocessing.R')
source('./functions.R')
library(MASS)
library(e1071)
library(class)
library(gam)

data <- read.csv(file = 'DS_Assessment.csv')
num_data <- pre_process(data)
n <- dim(num_data)[1]
p <- dim(num_data)[2] - 1

num_data[,1:p] <- scale(num_data[,1:p], center=TRUE,scale=TRUE)

K = 20
cv <- rep(0,K)
for(k in 1:K)
{
  knnPred <- function(train,test) { return(knn(train[,1:p], test[,1:p], train[,(p+1)],k=k)) }
  cv[k] <- cvError(knnPred,num_data,10)*100
}
plot(cv, main='miss-classification rates of KNN', xlab='value of K', ylab ='%age of miss-classification')
