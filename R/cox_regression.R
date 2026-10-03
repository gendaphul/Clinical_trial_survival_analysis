# step 4 :- Cox model........
# trying to find the association of other explanatory variables with the recurrence of the event 
# instead of just assuming that this is only due to the treatments.
# this regression considers the time-dependents variables as like hazard rate.
# Hazard rate is theinstanteneous rate of the risk, considering the individual survived till yet


cox_model <- coxph(
  Surv(time, status) ~ rx + age + sex + nodes,
  data = recurrence
)
summary(cox_model)


# plotting of Cox_regression line to the nodes............................!


ph_test <- cox.zph(cox_model)
ph_test
plot(ph_test)