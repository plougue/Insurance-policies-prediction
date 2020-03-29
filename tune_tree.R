source('./preprocessing.R')
source('./functions.R')
library(tree)

data <- read.csv(file = 'DS_Assessment.csv')
num_data <- pre_process(data)
n <- dim(num_data)[1]
p <- dim(num_data)[2] - 1
#num_data[,1:p] <- scale(num_data[,1:p], center=TRUE,scale=TRUE)


# Cross validate cost complexity pruning
#tree.fit <- tree(as.factor(Sale) ~ ., num_data,  split='deviance')
# Size<-cv.tree(tree.fit,, prune.tree)$size
# DEV<-rep(0,length(Size))
# for(i in (1:10)){
#   print('ok')
#   tree.cv=cv.tree(tree.fit,, prune.tree)
#   print(tree.cv$dev)
#   DEV<-DEV+tree.cv$dev
# }
# DEV<-DEV/10
# plot(tree.cv$size,DEV,type='b')
# 12 + best

# Plot best tree
# tree.pruned <- prune.tree(tree.fit, best=10)
# plot(print(tree.pruned))
# text(tree.pruned, pretty=0)


# Cv error of tree
treePred <- function(train,test) { tree.fit <- tree(as.factor(Sale) ~ ., train,  split='deviance')
tree.pruned <- prune.tree(tree.fit, k=0)
pred <- predict(tree.pruned,newdata=test)
return(pred[,1] < pred[,2]) }

print(cvError(treePred,num_data,5)*100)
      


library(randomForest)

randomForestPred <- function(train,test) {  fit=randomForest(as.factor(Sale) ~.,data=train,mtry=3)
return(predict(fit,newdata=test,type='response'))} 

print(cvError(randomForestPred, num_data, 5, verbose=TRUE) * 100)
# cv error = 1.981258
