
#Step-3:- Log-rank test & Cox_Regression model
# just to test whether the distribution of survival probability is same for all treatment or not
# using the H0 as All treatment have same distruibution of survival probability
# H1 :- At least one of them has different distribution of survival Probability.
#P-value interpretation is like if p-value is less than 0.05 (prob of type 1 error)
# then we reject H0 since we will get the evidence against H0.

library(survival)

logrank_test <- survdiff(
  Surv(time, status) ~ rx,
  data = recurrence
)
logrank_test


#summary(recurrence$time)
#table(recurrence$rx)
#max(recurrence$time)