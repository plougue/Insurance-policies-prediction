data = read.csv(file = 'DS_Assessment.csv')
n = dim(data)[1]
p = dim(data)[2]
# 
# data.is.empty = (data=='')
# data.is.empty[is.na(data.is.empty)] = TRUE
# incompleteRows = which(apply(data.is.empty,1,any))
# completeRows = which(!apply(data.is.empty,1,any))
# 
# 
# print(paste('Total number of sales : ', sum(data['Sale']), ' out of ', n))
# print(paste('Number of incomplete rows : ', length(incompleteRows), ' out of ', n))
# summary(data)
# 
# # Working only with complete rows
# data = data[completeRows,]
# 
# library(caret)
# 
# marital_dummy = predict(dummyVars(~Marital_Status, data=data),newdata=data)
# payment_dummy = predict(dummyVars(~Payment_Type, data=data),newdata=data)
# date_of_year = as.numeric(strftime(data$Date, format='%j'))
# 
# num_data = data.frame(Age = data$Age, 
#                       Veh_Value = data$Veh_Value,
#                       Tax = data$Tax,
#                       Price = data$Price,
#                       Veh_Mileage = data$Veh_Mileage,
#                       Credit_Score = data$Credit_Score,
#                       License_Length = data$License_Length,
#                       Date = date_of_year,
#                       Veh_Reg_Year = data$Veh_Reg_Year)
# num_data = cbind(num_data,marital_dummy[,2:3],payment_dummy[,2])
num_data=pre_process(data)
num_data.pca = prcomp(num_data, scale=TRUE, center=TRUE)
percentage_of_explained_variance = cumsum(num_data.pca$sdev**2) / sum(num_data.pca$sdev**2)
plot(percentage_of_explained_variance*100, 
     main='cumulative explained variance of pca components',
     xlab='consecutive linear subspace of pca',
     ylab='%age of explained variance')

num_data = data.frame(scale(num_data,center=TRUE,scale=TRUE))

n = dim(num_data)[1]
p = dim(num_data)[2]

print(abs(cor(num_data))>0.01)


X <- as.matrix(num_data[1:p])
U <- as.matrix(lda$scaling)
palette(c(sold.color, notSold.color))
plot(x=X%*%U, y=rep(0,n), col=num_data$Sale+1, pch=20, cex=0.1, main='FDA coordinates', xlab='Coordinate', ylab='')
