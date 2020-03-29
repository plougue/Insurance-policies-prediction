source('./preprocessing.R')
source('./functions.R')
library(e1071)

data <- read.csv(file = 'DS_Assessment.csv')
num_data <- pre_process(data)
n <- dim(num_data)[1]
p <- dim(num_data)[2] - 1
num_data[,1:p] <- scale(num_data[,1:p], center=TRUE,scale=TRUE)
fit<- glm(Sale ~.,data=num_data,family=binomial)
print(summary(fit))
plot(abs(fit$coefficients[2:(p+1)]))
