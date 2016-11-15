# Source : https://www.udemy.com/introduction-to-data-science/learn/v4/t/lecture/2369004




setwd("C:/Users/adilr/OneDrive - Hewlett Packard Enterprise/Work/Learning/Data Science/data_science/Model Validation")

##### Load data #####

salaryData= readRDS("./Data/salaryData.rds")

dim(salaryData)
head(salaryData)
summary(salaryData)


##### Set Variables #####

outcome="logSalary"

vars= setdiff(names(salaryData),
              c("logSalary","Salary","Player"))
vars


 ##### Test Train Split  #####

set.seed(45433622)

nr= nrow(salaryData)
#25% goes to test set
is.test=runif(nr)<=0.25

test=salaryData[is.test,]
train=salaryData[!is.test,]

#Add the marker for test set to original data
salaryData$is.test=is.test


 ##### Build linear model  ##### 


fmla<-paste(outcome,"~" ,paste(vars,collapse = "+"))
model=lm(fmla,data = train)
summary(model)
str(model)

#predict

salPred<-predict(model,newdata = salaryData)

#create a separate dataset to assess performace

perf= data.frame(logSalary=salaryData[[outcome]]
                 ,predSal=salPred
                 ,is.test=salaryData$is.test)
head(perf)
names(perf)

sqerr= (perf$logSalary-perf$predSal)^2

#Training error
train_error<-sqrt(mean(sqerr[!is.test]))
train_error
#Test Error
test_error<-sqrt(mean(sqerr[is.test]))
test_error

#Info : Test error must be larger than train error
# Test error is not much larger than train error meaning, this model isnt overfit

#Generalized error
train_error-test_error


# Plot the original and pred values to understand fit
library(ggplot2)

ggplot(perf,aes(x=predSal,y=logSalary,color=is.test)) +
  geom_point(aes(shape=is.test))+
  geom_abline(slope=1)
  


#### Create RF model for comparison ####

install.packages("randomForest")
library(randomForest)
mod = randomForest(train[,vars], y=train[,outcome])

perf = data.frame(logSalary = salaryData[[outcome]], 
                  pred = as.numeric(predict(mod, newdata=salaryData)), is.test=salaryData$is.test)
sqerr = (perf$logSalary - perf$pred)^2
         

#Training SQErr
sqrt(mean(sqerr[!is.test])) 

#Test Error

sqrt(mean(sqerr[is.test])) 


#Always try your model on the holdout data

######### Notes #########

# Observations
# 1. Training error of RF model is lower than that of LM. This doesnt mean that RF is a better model
# 2. Test error of RF model is higher than that of LM. Also the diff between RFs errors is comparatively larger.
#      This means RF model is overfit and hence not better than LM in this case.

