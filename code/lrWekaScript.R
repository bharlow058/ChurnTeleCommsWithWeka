library("MASS")
#library("foreign")
library("RWeka")

# RWeka documentation: http://cran.r-project.org/web/packages/RWeka/RWeka.pdf

print("Loading arff data...")

train <- read.arff(file = "../dataset/WEKA/Train.arff")
test <- read.arff(file = "../dataset/WEKA/Test.arff")

#NBModel <- NB(churn ~ .,data=train) 

print("Computin Reduced train")

reducedTrain <- train[,union(features1,union(features2,c("churn","appetency","upselling")))]
reducedTest <- test[,union(features1,union(features2,c("churn","appetency","upselling")))]

reducedTrain$churn = factor(reducedTrain$churn, labels=c("Change", "Stay"))
reducedTrain$appetency = factor(reducedTrain$appetency, labels=c("Change", "Stay"))
reducedTrain$upselling = factor(reducedTrain$upselling, labels=c("Change", "Stay"))

reducedTest$churn = factor(reducedTest$churn, labels=c("Change", "Stay"))
reducedTest$appetency = factor(reducedTest$appetency, labels=c("Change", "Stay"))
reducedTest$upselling = factor(reducedTest$upselling, labels=c("Change", "Stay"))

dme.exportARFF(reducedTrain, "reducedTrainDimRed")
dme.exportARFF(reducedTest, "reducedTestDimRed")



print("Traub Logistic Regression")

#LRModel <- Logistic(data=reducedTrain)


# This gives the performance summary that can be seen in WEKA. Although, this just shows the 
# performance of the training, rather than the performance on the test set
#summary(NBModel) 

# Evaluate model on the test set
#NBeval <- evaluate_Weka_classifier(NBModel, reducedTest, #            cost = matrix(c(0,1,1,0), ncol = 2), numFolds = 1, complexity = TRUE, seed = 123, class = TRUE)#
          

# Using the extracted features from PreProcess.r to reduce the dimensionality of the data
#reducedTrain <- train[,union(features1,union(features2,c("churn","appetency","upselling")))]
#reducedTest <- test[,union(features1,union(features2,c("churn","appetency","upselling")))]

#Logistic(formula, data, subset, na.action,control = Weka_control(), options = NULL)