pre_process <- function(data)
{
  n = dim(data)[1]
  p = dim(data)[2]
  
  data.is.empty = (data=='')
  data.is.empty[is.na(data.is.empty)] = TRUE
  incompleteRows = which(apply(data.is.empty,1,any))
  completeRows = which(!apply(data.is.empty,1,any))
  
  
  print(paste('Total number of sales : ', sum(data['Sale']), ' out of ', n))
  print(paste('Number of incomplete rows : ', length(incompleteRows), ' out of ', n))
  summary(data)
  
  # Working only with complete rows
  data = data[completeRows,]
  
  library(lubridate)
  day_of_month = as.numeric(strftime(data$Date, format='%d'))
  month = as.numeric(strftime(data$Date, format='%m'))
  year =  as.numeric(strftime(data$Date, format='%Y'))
  #dummy_month = predict(dummyVars(~strftime(Date, format='%Y'), data=data),newdata=data)
  is.lastDayOfMonth = days_in_month(as.Date(data$Date)) == day_of_month
  
  num_data = data.frame(Age = data$Age, 
                        Veh_Value = data$Veh_Value,
                        Tax = data$Tax,
                        Price = data$Price,
                        Veh_Mileage = data$Veh_Mileage,
                        Credit_Score = data$Credit_Score,
                        License_Length = data$License_Length,
                        Is_Divorced = data$Marital_Status=='D',
                        Is_Married = data$Marital_Status=='M',
                        Is_Cash = data$Payment_Type=='Cash',
                        Month = month,
                        Day_Of_Month = day_of_month,
                        #Is_LastDayOfMonth = is.lastDayOfMonth,
                        Veh_Reg_Delay = year - data$Veh_Reg_Year,
                        Sale = data$Sale)
  return(num_data)
}

pre_process_2 <- function(data)
{
  n = dim(data)[1]
  p = dim(data)[2]
  
  data.is.empty = (data=='')
  data.is.empty[is.na(data.is.empty)] = TRUE
  incompleteRows = which(apply(data.is.empty,1,any))
  completeRows = which(!apply(data.is.empty,1,any))
  
  
  print(paste('Total number of sales : ', sum(data['Sale']), ' out of ', n))
  print(paste('Number of incomplete rows : ', length(incompleteRows), ' out of ', n))
  summary(data)
  
  # Working only with complete rows
  data = data[completeRows,]
  
  marital_dummy = predict(dummyVars(~Marital_Status, data=data),newdata=data)
  payment_dummy = predict(dummyVars(~Payment_Type, data=data),newdata=data)
  date_of_year = as.numeric(strftime(data$Date, format='%j'))
  
  num_data = data.frame(Age = data$Age, 
                        Veh_Value = data$Veh_Value,
                        Tax = data$Tax,
                        Price = data$Price,
                        Veh_Mileage = data$Veh_Mileage,
                        Credit_Score = data$Credit_Score,
                        License_Length = data$License_Length,
                        Date = date_of_year,
                        Veh_Reg_Year = data$Veh_Reg_Year,
                        Sale = data$Sale)
  num_data = cbind(num_data,marital_dummy[,2:3],payment_dummy[,2])
  return(num_data)
}

pre_process_3 <- function(data)
{
  library(caret) # for DummyVars
  n = dim(data)[1]
  p = dim(data)[2]
  
  data.is.empty = (data=='')
  data.is.empty[is.na(data.is.empty)] = TRUE
  incompleteRows = which(apply(data.is.empty,1,any))
  completeRows = which(!apply(data.is.empty,1,any))
  
  
  print(paste('Total number of sales : ', sum(data['Sale']), ' out of ', n))
  print(paste('Number of incomplete rows : ', length(incompleteRows), ' out of ', n))
  summary(data)
  
  # Working only with complete rows
  data = data[completeRows,]
  
  library(lubridate)
  day_of_month = as.numeric(strftime(data$Date, format='%d'))
  month = as.numeric(strftime(data$Date, format='%m'))
  year =  as.numeric(strftime(data$Date, format='%Y'))
  month_dummy = predict(dummyVars(~as.factor(strftime(Date, format='%b')), data=data),newdata=data)
  is.lastDayOfMonth = days_in_month(as.Date(data$Date)) == day_of_month
  
  num_data = data.frame(Age = data$Age, 
                        Veh_Value = data$Veh_Value,
                        Tax = data$Tax,
                        Price = data$Price,
                        Veh_Mileage = data$Veh_Mileage,
                        Credit_Score = data$Credit_Score,
                        License_Length = data$License_Length,
                        Is_Divorced = data$Marital_Status=='D',
                        Is_Married = data$Marital_Status=='M',
                        Is_Cash = data$Payment_Type=='Cash',
                        Is_LastDayOfMonth = is.lastDayOfMonth,
                        Veh_Reg_Delay = year - data$Veh_Reg_Year)
  num_data = cbind(num_data,month_dummy[,2:12],data$Sale)
  colnames(num_data)[length(num_data)] = "Sale"
  return(num_data)
}
pre_process_4 <- function(data)
{
  library(caret) # for DummyVars
  n = dim(data)[1]
  p = dim(data)[2]
  
  data.is.empty = (data=='')
  data.is.empty[is.na(data.is.empty)] = TRUE
  incompleteRows = which(apply(data.is.empty,1,any))
  completeRows = which(!apply(data.is.empty,1,any))
  
  
  print(paste('Total number of sales : ', sum(data['Sale']), ' out of ', n))
  print(paste('Number of incomplete rows : ', length(incompleteRows), ' out of ', n))
  summary(data)
  
  # Working only with complete rows
  data = data[completeRows,]
  
  library(lubridate)
  day_of_year = as.numeric(strftime(data$Date, format='%j'))
  year =  as.numeric(strftime(data$Date, format='%Y'))

  
  num_data = data.frame(Age = data$Age, 
                        Veh_Value = data$Veh_Value,
                        Tax = data$Tax,
                        Price = data$Price,
                        Veh_Mileage = data$Veh_Mileage,
                        Credit_Score = data$Credit_Score,
                        License_Length = data$License_Length,
                        Is_Divorced = data$Marital_Status=='D',
                        Is_Married = data$Marital_Status=='M',
                        Is_Cash = data$Payment_Type=='Cash',
                        Day_Of_Year = day_of_year,
                        Veh_Reg_Delay = year - data$Veh_Reg_Year,
                        Sale = data$Sale)
  return(num_data)
}
pre_process_5 <- function(data)
{
  library(caret) # for DummyVars
  n = dim(data)[1]
  p = dim(data)[2]
  
  data.is.empty = (data=='')
  data.is.empty[is.na(data.is.empty)] = TRUE
  incompleteRows = which(apply(data.is.empty,1,any))
  completeRows = which(!apply(data.is.empty,1,any))
  
  
  print(paste('Total number of sales : ', sum(data['Sale']), ' out of ', n))
  print(paste('Number of incomplete rows : ', length(incompleteRows), ' out of ', n))
  summary(data)
  
  # Working only with complete rows
  data = data[completeRows,]
  
  library(lubridate)
  day_of_year = as.numeric(strftime(data$Date, format='%j'))
  year =  as.numeric(strftime(data$Date, format='%Y'))
  
  
  num_data = data.frame(Age = data$Age, 
                        Veh_Value = data$Veh_Value,
                        Tax = data$Tax,
                        Price = data$Price,
                        Veh_Mileage = data$Veh_Mileage,
                        Sale = data$Sale)
  return(num_data)
}

