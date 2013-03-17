# RWeka documentation: http://cran.r-project.org/web/packages/RWeka/RWeka.pdf
library(RWeka)

train <- read.arff(file = "../dataset/WEKA/Train.arff")
test <- read.arff(file = "../dataset/WEKA/Test.arff")

# Train Naive Bayes model with churn as the label and predict on the test set
NB <- make_Weka_classifier("weka/classifiers/bayes/NaiveBayes")
NBModel <- NB(churn ~ .,data=train) 

# This gives the performance summary that can be seen in WEKA. Although, this just shows the 
# performance of the training, rather than the performance on the test set
summary(NBModel) 

# Evaluate model on the test set
NBeval <- evaluate_Weka_classifier(NBModel, reducedTest, 
            cost = matrix(c(0,1,1,0), ncol = 2), numFolds = 1, 
            complexity = TRUE, seed = 123, class = TRUE)


# Using the extracted features from PreProcess.r to reduce the dimensionality of the data
reducedTrain <- train[,union(features1,union(features2,c("churn","appetency","upselling")))]
reducedTest <- test[,union(features1,union(features2,c("churn","appetency","upselling")))]





