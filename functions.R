cvError <- function(predictionFUN, data, n_splits, verbose=FALSE)
{
  n = dim(data)[1]
  shuffle = sample(n,n)
  split = split(shuffle, ceiling(seq_along(shuffle)/(n/10)))
  cv.err <- 0
  for (i in 1:n_splits)
  {
    test.indices = unlist(split[i])
    data.test = data[test.indices, ]
    data.train = data[-test.indices, ]
    perf <-table(data.test$Sale,predictionFUN(data.train,data.test))
    err <- (1-sum(diag(perf))/length(test.indices))
    cv.err <- cv.err + err/n_splits
    if(verbose == TRUE)
    {
      print(paste('Error ', i, ' : ', err))
    }
  }
  return(cv.err)
}
