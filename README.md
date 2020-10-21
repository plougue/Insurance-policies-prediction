# Insurance-policies-prediction
A one week project aiming at making predictions regarding wether or not insurances policies lead to a sale.
Files are either :
- R scripts made for exploring / tuning / evaluating different machine learning methods
- Their resulting plots
- **MOST IMPORTANTLY** : report.pdf, a 20 page technical report explaining the process for finding the best method, some analysis of the data, as well ase some insights for a potential decision maker. It is basically a much longer and more detailed version of the summary below with plots.

Here is a small summary of the work I've done here : 

The challenge consisted in analyzing a set of vehicle insurance policy proposals with several characteristics related to them and whether or not they led to a sale. I had to choose the best possible classification algorithm to predict if future proposals will be sold or not. I also had to give insights for decision makers.

I first tried to define the problem and do an extensive preliminary analysis of the data by looking at what do the features mean, how many policies are there in the set and how many values are missing. I also thought about indicators for measuring the quality of a classifier. If the idea is to help potential sellers know which client to call, false negatives should be punished more heavily than false positives because the consequences are worse. Without knowing if that was the precise use-case and only having a limited amount of time I just decided to use the miss-classification rate, leaving the issue for further work.

A pattern I noticed when analyzing the features is that every potential insurance policy was meant to start in 2016. This observation made me use a cautious approach when deciding which model I chose in the end. By that I mean that I would prefer simpler models even if they performed slightly worse in terms of cross-validation errors because more complex models might overfit and recognize pattern that only occur in 2016. This overfit would not be captured by cross-validation because they are only ever tested on policies in 2016 !

Transforming dates into numerical values also raised questions about how dates should be treated with regards to policy sale (do they follow yearly patterns or overall trends ?). There were several other examples of features needing discussion : a lot of client credit scores were 9999 to account for an "arbitrary high" value, proportion of policy sold was very high and I didn't know if it was representative, and so on...
Overall I tried to do a lot of analysis on how to transform features into numerical values, what to keep it mind when choosing a model, what did all the features mean and how they related to the potential sales of policies.
After transforming everything into numerical values, I tried several classification techniques on the data set using R : logistic regression, lda, qda, naive bayes, KNN, decision tree and random forest. I tuned hyper-parameters for SVM with linear, polynomial, and RBF kernels as well.

The two methods with the lowest errors were SVM with a RBF kernel and QDA and I decided to chose QDA because it is much less prone to overfitting.

I also produced two bits of insights for potential decision makers. The first one was some kind of relative importance of features in deciding if a policy is sold and whether its effect was positive or negative by using coefficients of LDA (on a normalized set) that had a 98% classification rate. (this only works because features were not much correlated). The second was a 94% classification rate small decision tree that could give decision makers a cognitive intuition of "what thought process should I have when trying to know if a policy will be sold ?". 
