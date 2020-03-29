source('./preprocessing.R')
source('./functions.R')
library('e1071')
data <- read.csv(file = 'DS_Assessment.csv')
num_data <- pre_process_5(data)
n <- dim(num_data)[1]
p <- dim(num_data)[2] - 1
num_data[,1:p] <- scale(num_data[,1:p], center=TRUE,scale=TRUE)

gamma = 0.01
cost = 100
svmPred <- function(train,test){svm.fit <-svm(as.factor(Sale) ~ .,train,gamma=gamma,cost=cost)
  return(as.numeric(predict(svm.fit,test))-1)}


print(cvError(svmPred,num_data,5, verbose=TRUE)*100)

# gamma = 0.01, cost = 10 : 1.338688
# gamma = 0.01, cost = 100 : 1.325301
# gamma = 0.01, cost = 100 : 1.164659 (preprocessing_4)
