homemadeDA <- function(data)
{
  numerical_values <- cbind(data$Age, data$Veh_Value, data$Tax, data$Price,
                            data$Veh_Mileage, data$License_Length, data$Credit_Score)
  V <- cov(numerical_values)
  mean <- mean(numerical_values)
  
}

naiveQDA <- function(data)
{
  p = dim(data)[2] - 1
  return(data.frame(V1 = diag(cov(data[data$Sale==1,1:p])),
  V0 = diag(cov(data[data$Sale==0,1:p])),
  mean1 = colMeans(data[data$Sale==1,1:p]),
  mean0 = colMeans(data[data$Sale==0,1:p]),
  p1 = mean(data$Sale==1),
  p0 = mean(data$Sale==0)))
}

predNaiveQDA <- function(naiveQDA, data)
{
    p = dim(data)[2] - 1
    
    
    score1 = - 0.5*rowSums(sweep(t(t(data[,1:p])-naiveQDA$mean1)**2, 2, (1/naiveQDA$V1), `*`))
    - 0.5* log(prod(naiveQDA$V1)) + log(naiveQDA$p1[1])
    score0 = - 0.5*rowSums(sweep(t(t(data[,1:p])-naiveQDA$mean0)**2, 2, (1/naiveQDA$V0), `*`))
    - 0.5* log(prod(naiveQDA$V0)) + log(naiveQDA$p0[1])
    return(as.numeric(score1>score0))
}
splitLDA <- function(data)
{
  data_maxCredit <- data[data$Credit_Score>=max(data$Credit_Score),]
  data_notMaxCredit <- data[data$Credit_Score<max(data$Credit_Score),]
  data_maxCredit$Credit_Score <- NULL
  
  res <- list(lda(Sale~.,data=data_maxCredit), lda(Sale~.,data=data_notMaxCredit))
  
  return(res)
}

splitQDA <- function(data)
{
  data_maxCredit <- data[data$Credit_Score>=max(data$Credit_Score),]
  data_notMaxCredit <- data[data$Credit_Score<max(data$Credit_Score),]
  data_maxCredit$Credit_Score <- NULL
  
  res <- list(qda(Sale~.,data=data_maxCredit), qda(Sale~.,data=data_notMaxCredit))
  
  return(res)
}

predSplitDA <- function(splitDA, data)
{
  res <- rep(0,dim(data)[1])
  isMaxCredit <- data$Credit_Score>=max(data$Credit_Score)
  
  test_maxCredit = data[isMaxCredit,]
  test_notMaxCredit = data[-isMaxCredit,]
  test_maxCredit$Credit_Score <- NULL
  
  res[isMaxCredit] <- as.numeric(predict(splitDA[[1]],newdata=test_maxCredit)$class) - 1
  res[-isMaxCredit] <- as.numeric(predict(splitDA[[2]],newdata=test_notMaxCredit)$class) - 1
  return (res)
}


nqda <- naiveQDA(num_data)
pred <- predNaiveQDA(nqda, num_data)
mean(pred==num_data$Sale)
