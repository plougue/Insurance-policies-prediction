source('./preprocessing.R')
source('./functions.R')
library(MASS)
library(pROC)
data <- read.csv(file = 'DS_Assessment.csv')
num_data <- pre_process(data)
n <- dim(num_data)[1]
p <- dim(num_data)[2] - 1
num_data[,1:p] <- scale(num_data[,1:p], center=TRUE,scale=TRUE)

lda <- lda(Sale~.,data=num_data)
sold.color <- rgb(40,40,255,max = 255, alpha=155, names = "lt.blue")
notSold.color <- rgb(255,0,0, max = 255, alpha=155, names = "lt.pink")
palette(c(sold.color, notSold.color))
relative_weights <- abs(lda$scaling)
names(relative_weights) <- colnames(num_data)[1:p]
plot(relative_weights, col = 1.5+0.5*-sign(lda$scaling), pch=19, ylab='Relative weight', xlab='Predictor')
text(x=1:p, y=abs(lda$scaling)+0.2, colnames(num_data)[1:p], srt=45, cex=0.7, col= 1.5+-0.5*sign(lda$scaling))#abs(lda$scaling)+1
text(x=4, y=abs(lda$scaling)[4]-0.2, 'Price', srt=45, cex=0.7, col=sold.color)
legend("topright", c("more likely to be sold when increased","more likely not to be sold when increased"), fill=c(sold.color,notSold.color), cex=0.7)
qda <- qda(Sale~.,data=num_data)


# Plotting ROC curve
test = sample(n,n/10)

lda <- lda(Sale~.,data=num_data[-test,])
predict <- predict(lda,newdata=num_data[test,1:p])
lda.roc <- roc(num_data[test,]$Sale, as.vector(predict$x))
plot(lda.roc, print.thres=TRUE)


## WORK ON PLOTTING ROC WITH QDA USING RRCOV
