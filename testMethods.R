source('./preprocessing.R')
source('./functions.R')
source('./homemadeDA.R')
library(MASS)
library(e1071)
library(class)
library(gam)

data <- read.csv(file = 'DS_Assessment.csv')
num_data <- pre_process(data)
n <- dim(num_data)[1]
p <- dim(num_data)[2] - 1
num_data[,1:p] <- scale(num_data[,1:p], center=TRUE,scale=TRUE)

par(mar=c(5.1, 4.1, 4.1, 4.1))
plot(abs(cov(num_data[,1:p])), main = 'covariance matrix'
     , axis.col=list(cex.axis=0.5), axis.row=list(cex.axis=0.6)
     , xlab='',ylab='', fmt.cell='%.2f')

ldaPred <- function(train,test) { lda <- lda(Sale~.,data=train)
pred <- predict(lda,newdata=test)
return(pred$class) }

qdaPred <- function(train,test) { qda <- qda(Sale~.,data=train)
pred <- predict(qda,newdata=test)
return(pred$class) }

naiveBayesPred <- function(train,test) { bayes <- naiveBayes(as.factor(Sale)~.,data=train)
pred <- predict(bayes,newdata=test)
return(pred) }

logRegPred <- function(train,test) {fit<- glm(Sale ~.,data=train,family=binomial)
pred<-predict(fit,newdata=test,type='response')
return(pred>0.5)
}

splitLDAPred <- function(train,test){ fitted <- splitLDA(train)
return(predSplitDA(fitted,test))}

splitQDAPred <- function(train,test){ fitted <- splitQDA(train)
return(predSplitDA(fitted,test))}

naiveQDAPred <- function(train,test){ fitted <- naiveQDA(train)
return(predNaiveQDA(fitted,test))}

knnPred <- function(train,test) { return(knn(train[,1:p], test[,1:p], train[,(p+1)],k=5)) }



print(cvError(qdaPred,num_data,5)*100)
# 1.18697
print(cvError(ldaPred,num_data,10)*100)
# 2.204373
print(cvError(naiveBayesPred,num_data,10)*100)
# 7.166444
print(cvError(logRegPred,num_data,10)*100)
# 1.840696
print(cvError(knnPred,num_data,10)*100)
# 3.409192
print(cvError(splitLDAPred,num_data,10)*100)
# 2.222222
print(cvError(splitQDAPred,num_data,10)*100)
# 1.494868
print(cvError(naiveQDAPred,num_data,10)*100)
# 8.038822