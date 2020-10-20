# Insurance-policies-prediction
A one week project aiming at making predictions regarding wether or not insurances policies lead to a sale.
Files are either :
- R scripts made for exploring / tuning / evaluating different machine learning methods
- Their resulting plots
- **MOST IMPORTANTLY** : report.pdf, a report explaining the process for finding the best method, some analysis of the data, as well ase some insights for a potential decision maker.

Here is a small summary of the work I've done here : 

The challenge consisted in analyzing a set of vehicle insurance policy proposals with several characteristics related to them and whether or not they led to a sale. I had to chose the best possible classifier to predict whether of not of future clients will buy a policy for their vehicle. I also had to give insights for decision makers to help them understand what are the most important factors for a sale.

I tried to define the problem by first doing an extensive preliminary analysis of the data : what are the different features, what do they mean, how many policies are there in the set, what are the features and how many values are missing. I thought about indicators for measuring the quality of a classifier. If the idea is to help potential sellers know which client to call, false negatives should be punished more heavily than false positives because the consequences are worse. Without knowing if that was the precise use-case and only having a limited amount of time I just decided to use the missclassification rate, leaving the issue for further work.

The first very important pattern I noticed when analyzing the features is that every potential insurance policy was meant to start in 2016. I decided to transform the date into a "day of the year" seasonal value rather than "day since X date in the past" value by hypothesing than a change at the end of 2016 is probably due to seasonal change rather than an overall trend that will continue in 2017. This observation also led me to use a cautious approach when deciding which model I chose in the end. By that I mean that simpler models less prone to overfitting should be preferred even if they perform slightly worse in terms of cross-validation errors because more complex models might overfit by recognizing pattern that only occur during 2016. This overfit would not be captured by cross-validation because every they are only ever tested on policies for 2016 !

The second pattern was that there was a very large amount of policies that were sold, and further investigation were to be made to understand whether or not the percentage or sales was representative, or on the contrary policies that were sold were more likely to be recorded. If that was the case it could have led to biases for algorithms whose training depends on the proportion of sales!

Some other features needed further discussion : the data involved a client credit score and many of them were 9999 which I intepreted as an "arbitrary high" value for some kind of infinite score. I also decided to transform "vehicule registration year" into "age of the vehicle when the policy was sold" because the age of the vehicle might have a bigger impact on the sale than the year itself.

Overall I tried to do a lot of analysis on the meaning of the features, how to transform them into numerical values, what to keep it mind when chosing a model, and also how did everything relate to the potential sales of policies.

After transforming everything into numerical values, I tried several classification techniques on the data set using R : logistic regression, lda, qda, naive bayes, KNN, decision tree and random forrest. I tuned hyperparameters for SVM with linear, polynomial, and RBF kernels as well.

The two methods with the lowest error were SVM with a RBF kernel and QDA and I decided to chose QDA because it is much less prone to overfitting and I decided to be cautious for reasons mentionned above.

In order to give insight for decision makers, I decided to use two things. The first one was computing some kind of relative importance of features and whether or not it was positive or negatives by using coefficients of LDA (on a normalized set) that had a 98% sucess rate. This works well because there is very little covariance between the different features. The second way to give insight was to plot a 94% success rate decision tree that could give a decision maker a cognitive intuition of "what thought process should I have when trying to know if a policy will be sold ?".

The work was presented in a 20 page technical reports that I'm pretty proud of that pretty much explain everything I've told you there with much more details. If interested you can find it here : https://raw.githubusercontent.com/plougue/Insurance-policies-prediction/master/report.pdf. (it has pretty plots)

