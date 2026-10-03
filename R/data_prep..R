
#Step1- Data Preparation and Understanding


# Status column- explain the occurence of event original data contain two type of 
#study of [etyep]-"death(2)" & "recurrence(1)". We choose only recurrence one for the project
#for status if 0 then event not occured and if 1 then event occured.
#there was three treatment groups as = Observation, Levo and Levo+ 5FU
#number of  affected lymph nodes due to colon cancer
#other remaining things are not required for the project
#..........................................................................................................!

library(survival)
library(ggplot2)

data(colon)
head(colon)

summary(colon)
str(colon)
dim(colon)


print(colon)

recurrence <- subset(colon, etype == 1)
recurrence

dim(recurrence)
summary(recurrence)

recurrence <- recurrence[, c("age","rx","sex","time","status","etype","id","nodes")]
recurrence

summary(recurrence)
dim(recurrence)
table(recurrence$rx)

is.null(recurrence)    # security checking



library(ggplot2)


# Create ggplot
ggplot(data=recurrence, aes(x = rx, y = time)) +
  geom_point(color = "red", size = 1) +
  # geom_smooth(se = TRUE, color = "green", method = "loess") +
  labs(title = "Distribution of the treatments", x = "Treatment", y = "Time") +
  theme_classic()


is.null(recurrence)    # security checking