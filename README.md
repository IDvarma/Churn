# Churn

Churn Analysis refers to customer attrition rate in a company. This analysis helps companies to identity the cause of the churn and implement effective strategies for retention.

Telecome Customer Churn analysis is done on a dataset with 100000 observations with 173 features. Since it’s hard to perform analysis on all 173 features so we have to choose that features that cause maxmum impact on customer’s churn. So we proceeded as below to select the features for analysis.

a.)	Group the observations by churn class( 0/1).
b.)	Compute means of continuous variables for both the classes
c.)	Take percentage change of both the classes
d.)	Sort the % change means and choose the top 10-15 variables for analysis.
e.)	Be sure that these 10-15 variables are not correlated.
f.)	Now we are done with continuous variables, it’s time for categorical variables.
g.)	We choose that categorical variables that has zero missing values and used stepwise method to find variables that effects % concordance.
h.)	Used some more continuous variables with critical thinking and common sense that are not included in above 10-15 variables selected using % change in means technique.
i.)	Finally selected variables are tested for correlation and uncorrelated variables are used for analysis.

Features Selected : avgqty 	hnd_price  	mou_opkv_ Mean  	months 	eqpdays change_mou 	change_rev 	roam_Mean 	threeway_Mean 	asl_flag	

# Data Preparation
The above selected features have missing values which need to be imputed. Below is how we imputed. Used asl_flag categorical variable as class and found the mean, median for the features with missing values. Then imputed the missing values with the median of respective feature under each class.
Since we imputed the missing values with median values we used data to 100% with out any loss.

# Model Fitness:
Both AIC & BIC(SC) are lower than intercept only model suggesting our model is a good fit.

# Odd Ratio Estimators interpretation. 
Below is interpretation of each feature in model using odds ratio having other factors fixed
 Avgqty : For every unit increase in average number of calls then odds of churn increases by 1.001 compared to no churn.
hnd_price : For every unit increase in handset price then odds of churn decreases by 0.998 compared to no churn.
mou_opkv_Mean:  For every unit increase in mou_opkv_Mean then odds of churn is same as no churn.
 Months: For every unit increase in months of usage then aodds of churn increases by 0.986 compared to no churn.
 Eqpdays: For every unit increase in eqpdays then odds of churn increases by 1.001 compared to no churn.
 change_mou: For every unit increase in change_mou then odds of churn is same as no churn.
 change_rev: For every unit increase in change_rev then odds of churn increases by 1.002 compared to no churn
 roam_Mean: For every unit increase in roam_Mean then odds of churn increases by 1.004 compared to no churn
 threeway_Mean : For every unit increase in threeway_Mean then  odds of churn increases by 0.967 compared to no churn.
asl_type: For a person with Account Spending Limits = ‘Y’ the the odds of churn is increases by 0.71 compated to a person with Account Spending Limits = ‘N’

# Top 3 Variables: Found based on Wald Chi-square value
eqpdays
hnd_price
months
# Other Features that can improve model
a.)	Deals – Deals that offer lower charges for calls per minute, high speed internet at lower price can reduce the churn rate.
b.)	Having data about network availability or frequency of call drop can help model fit better.
c.)	For targeting international students like us – night call rates effects churn rate.

Percentage Concordance = 59.2%
Hit Ratio = % of events correctly classified 
= (True positive + False Neagtive)/Total = (28045+28961)/100000 = 57%
Sensitivity = 56.5%
