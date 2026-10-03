#Step -2:-  Kaplan Meier Analysis
#Since data is prepared for the analysis.
# We are using the Kaplan Meier Analysis for the estimation of survival probabilities along with the time.
# Since logistic regresion can give the prob but can't consider the time parameter for the calculation.
# So we considered the Kaplan Meier Analysis which gives the prob of recurrence-free survival prob with 
#consideration of individual patient with time duration of record.
#..........................................................................................................!



km_model <- survfit(
  Surv(time, status) ~ rx,                    #Fitting Survival Model for the each treatment group.
  data = recurrence
)

summary(km_model)
group_color <-c("black","red","green")

plot(km_model,
     col = group_color,
     lwd = 1,
     xlab = "Time(days)",
     ylab = "Recurrence-free survival prob",
     main = "K-M Survival Curves")

legend( "topright",
        col = group_color,
        legend=c("Obs","Lev","Lev+5FU"),
        lwd = 2,
        bty = "n"
)





#........From this we can see that.....
#1) treatment with the Lev+ 5 FU has  comapritively more survival probability  
# also along with that survival probability curve for the Observations and the Lev has almost
# same distribution of survivals
#
#........................................................................................................!