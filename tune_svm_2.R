source('./preprocessing.R')
source('./functions.R')
library('e1071')
data <- read.csv(file = 'DS_Assessment.csv')
num_data <- pre_process_5(data)
n <- dim(num_data)[1]
p <- dim(num_data)[2] - 1
num_data[,1:p] <- scale(num_data[,1:p], center=TRUE,scale=TRUE)

# testing linear kernel
# for (c in 10**(-3:3))
# {
#   svmPred <- function(train,test){svm.fit <-svm(as.factor(Sale) ~ .,train,kernel="linear",cost=c)
#   return(as.numeric(predict(svm.fit,test))-1)}
#   print(paste('c =', c, ':', cvError(svmPred,num_data,5)*100))
# }
# RESULT :
# [1] "c = 0.001 : 2.01249442213298"
# [1] "c = 0.01 : 1.80276662204373"
# [1] "c = 0.1 : 1.81615350290049"
# [1] "c = 1 : 1.66889781347613"
# [1] "c = 10 : 1.81615350290049"
# plot(x=x,y=y, log='x', main = 'Linear kernel svm classification tuning', ylab='%age of miss-classification', xlab='cost')

# testing polynomial kernel
coef0 = 1

# for(gamma in c(1, 0.1, 10))
# {
#    for (c in c(1, 0.1, 10))
#    {
#       for (degree in 2:4)
#       {
#          svmPred <- function(train,test){
#          svm.fit <-svm(as.factor(Sale) ~ .,train,kernel="polynomial",cost=c, coef0=coef0, degree=degree, gamma=gamma)
#          return(as.numeric(predict(svm.fit,test))-1)}
#          print(paste('c =', c, ',', 'degree =', degree, ',', 'gamma =', gamma, ',', 'coef0 =', coef0, ':',  cvError(svmPred,num_data,5)*100))
#       }
#    }
# }

# [1] "c = 10 , gamma = 0.1 , coef0 = 0.1 : 1.41454707719768"
# [1] "c = 10 , gamma = 0.1 , coef0 = 1 : 1.3520749665328"
# [1] "c = 10 , gamma = 0.1 , coef0 = 10 : 1.45470771976796"
# c = 1 , gamma = 0.333333333333333 , coef0 = 0.333333333333333 : 1.42793395805444



costs = c(10,100,1000)
gammas = c(0.1,0.01,0.001)
err <- matrix(rep(0,length(costs)*length(gammas)), nrow=length(costs), ncol=length(gammas))
i <- 0
for (cost in costs)
{
  i <- i + 1
  j <- 0
  for(gamma in gammas)
  {
    j <- j + 1
    for (k in 1:10)
    {
      train = sample(n,0.8*n)
      svm.fit <- svm(as.factor(Sale)~., data=num_data[train,],gamma = gamma, cost = cost)
      err[i,j] <- err[i,j] + (1 - mean(predict(svm.fit,newdata=num_data[-train,]) == num_data[-train,]$Sale))/10
    }
    print(paste('gamma =', gamma, ', cost =', cost, ', err =', 100*err[i,j]))
  }
  print(paste(i, '/', length(costs)))
}
library(plot.matrix)
par(mar=c(5.1, 4.1, 4.1, 4.1)) # adapt margins
rownames(err) <- costs 
colnames(err) <- gammas 
plot(100*err, fmt.cell='%.3f', xlab='gamma', ylab='cost')
