data = read.csv(file = 'DS_Assessment.csv')
n = dim(data)[1]
p = dim(data)[2]

dataSold = data[data$Sale == 1,1:(p-1)]
dataNotSold = data[data$Sale == 0,1:(p-1)]

sold.color <- rgb(40,40,255,max = 255, alpha = 80, names = "lt.blue")
notSold.color <- rgb(255,0,0, max = 255, alpha = 80, names = "lt.pink")


breaks = pretty(min(data$Age[!is.na(data$Age)]):(max(data$Age[!is.na(data$Age)])+1), n=50)
sold.hist.age <- hist(dataSold$Age,breaks=breaks, plot=FALSE)
notSold.hist.age <- hist(dataNotSold$Age,breaks=breaks, plot=FALSE)

breaks = pretty(min(data$Veh_Value[!is.na(data$Veh_Value)]):(max(data$Veh_Value[!is.na(data$Veh_Value)])+1), n=50)
sold.hist.veh <-hist(dataSold$Veh_Value,breaks=breaks, plot=FALSE)
notSold.hist.veh <- hist(dataNotSold$Veh_Value,breaks=breaks, plot=FALSE)

breaks = pretty(min(data$Tax[!is.na(data$Tax)]):(max(data$Tax[!is.na(data$Tax)])+1), n=50)
sold.hist.tax <-hist(dataSold$Tax,breaks=breaks, plot=FALSE)
notSold.hist.tax <- hist(dataNotSold$Tax,breaks=breaks, plot=FALSE)


par(mfrow=c(1,1))
plot(sold.hist.age, col = sold.color,freq=FALSE, main='Within-class distribution of Age', xlab='Age')
plot(notSold.hist.age, col = notSold.color, freq=FALSE, add = TRUE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))

plot(notSold.hist.veh, col = notSold.color, freq=FALSE, main='Within-class distribution of Vehicle Value', xlab='Vehicle Value')
plot(sold.hist.veh, col = sold.color,  add = TRUE, freq=FALSE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))

plot(sold.hist.tax, col = sold.color, freq=FALSE, main='Within-class distribution of Tax', xlab='Tax')
plot(notSold.hist.tax, col = notSold.color, add = TRUE, freq=FALSE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))


breaks = pretty(min(data$Price[!is.na(data$Price)]):(max(data$Price[!is.na(data$Price)])+1), n=50)
sold.hist.price <- hist(dataSold$Price,breaks=breaks, plot=FALSE)
notSold.hist.price <- hist(dataNotSold$Price,breaks=breaks, plot=FALSE)

breaks = pretty(min(data$Veh_Mileage[!is.na(data$Veh_Mileage)]):(max(data$Veh_Mileage[!is.na(data$Veh_Mileage)])+1), n=50)
sold.hist.veh <-hist(dataSold$Veh_Mileage,breaks=breaks, plot=FALSE)
notSold.hist.veh <- hist(dataNotSold$Veh_Mileage,breaks=breaks, plot=FALSE)

notNaCreditScore = data$Credit_Score[!is.na(data$Credit_Score)]
breaks = pretty(min(notNaCreditScore):(max(notNaCreditScore[notNaCreditScore<9999])+1), n=50)
sold.hist.credit <-hist(dataSold$Credit_Score[dataSold$Credit_Score<9999],breaks=breaks, plot=FALSE)
notSold.hist.credit <- hist(dataNotSold$Credit_Score[dataNotSold$Credit_Score<9999],breaks=breaks, plot=FALSE)

par(mfrow=c(1,1))

plot(notSold.hist.price, col = notSold.color, freq=FALSE, main='Within-class distribution of Price', xlab='Price')
plot(sold.hist.price, col = sold.color,freq=FALSE, add = TRUE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))

plot(notSold.hist.veh, col = notSold.color, freq=FALSE,  main='Within-class distribution of Vehicle Mileage', xlab='Vehicle Mileage')
plot(sold.hist.veh, col = sold.color,  add = TRUE, freq=FALSE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))


plot(sold.hist.credit, col = sold.color, freq=FALSE, ,  main='Within-class distribution of <9999 Credit Score ', xlab='Credit Score')
plot(notSold.hist.credit, col = notSold.color, add = TRUE, freq=FALSE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))

breaks = pretty(min(data$License_Length[!is.na(data$License_Length)]):(max(data$License_Length[!is.na(data$License_Length)])+1), n=50)
sold.hist.license_length <- hist(dataSold$License_Length,breaks=breaks, plot=FALSE)
notSold.hist.license_length <- hist(dataNotSold$License_Length,breaks=breaks, plot=FALSE)

sold.proportion_of_9999_credit = 
  c(length(dataSold$Credit_Score[dataSold$Credit_Score<9999]), 
    length(dataSold$Credit_Score[dataSold$Credit_Score>=9999]))
sold.proportion_of_9999_credit <- sold.proportion_of_9999_credit/sum(sold.proportion_of_9999_credit)
names(sold.proportion_of_9999_credit) <- c('Not max credit', 'Max credit')
notSold.proportion_of_9999_credit = 
  c(length(dataNotSold$Credit_Score[dataNotSold$Credit_Score<9999]), 
    length(dataNotSold$Credit_Score[dataNotSold$Credit_Score>=9999]))
notSold.proportion_of_9999_credit <- notSold.proportion_of_9999_credit/sum(notSold.proportion_of_9999_credit)
barplot(sold.proportion_of_9999_credit, col = sold.color,  main='Proportion of 9999 Credit Score', ylab='proportion')
barplot(notSold.proportion_of_9999_credit, add=TRUE, col=notSold.color)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))

plot(sold.hist.license_length, col = sold.color, freq=FALSE,  main='Within-class distribution of License Length ', xlab='License Length')
plot(notSold.hist.license_length, col = notSold.color, add = TRUE, freq=FALSE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))

datesSold =  as.numeric(strftime(dataSold$Date[dataSold$Date!=''], format='%d'))
datesNotSold =  as.numeric(strftime(dataNotSold$Date[dataNotSold$Date!=''], format='%d'))
barplot(table(datesSold)/length(datesSold),col = sold.color, main='Within-class distribution of day in month ', xlab='Day in month')
barplot(table(datesNotSold)/length(datesNotSold),col = notSold.color, add=TRUE)
legend("bottomleft", c("sold","not sold"), fill=c(sold.color,notSold.color))

barplot(table(dataSold$Marital_Status)[2:4]/length(dataSold$Marital_Status), col=sold.color,   main='Proportion of Marriage Status', ylab='proportion')
barplot(table(dataNotSold$Marital_Status)[2:4]/length(dataNotSold$Marital_Status), col=notSold.color, add=TRUE)
legend("topleft", c("sold","not sold"), fill=c(sold.color,notSold.color))

barplot(table(dataSold$Payment_Type)[2:3]/length(dataSold$Payment_Type), col=sold.color,  main='Proportion of Payment Type', ylab='proportion')
barplot(table(dataNotSold$Payment_Type)[2:3]/length(dataNotSold$Payment_Type), col=notSold.color, add=TRUE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))

barplot(table(dataSold$Veh_Reg_Year)/length(dataSold$Veh_Reg_Year), col=sold.color, ,  main='Distribution of Vehicle Registration Year', ylab='proportion', xlab='registration year')
barplot(table(dataNotSold$Veh_Reg_Year)/length(dataNotSold$Veh_Reg_Year), col=notSold.color, add=TRUE)
legend("topright", c("sold","not sold"), fill=c(sold.color,notSold.color))

# par(mfrow=c(1,1))
# numericalColumn = c('Age', 'Veh_Value', 'Tax', 'Price', 'Veh_Mileage', 'Credit_Score', 'License_Length', 'Date', 'Veh_Reg_Year')
# plot(data[data$Credit_Score<9999 & data$Sale==1,numericalColumn], pch = 16, cex = .3, col=sold.color)
# plot(data[data$Credit_Score<9999 & data$Sale==0,numericalColumn], pch = 16, cex = .3, col=notSold.color, add=TRUE)
