# This script will be used to import all the data, preprocess it and export it to .csv or .arff for weka use.

# Loading up the preProcessing functions.
source("dmePreProcess.R")
# Loading up the models (SVM for now)
# source("dmeModels.R")

# Imports the training data with the 3 labels attached
orange.train <- dme.importData(data=TRUE)

# Convert the data to numerical as well as replace empty spaces with NA
orange.train.NA <- dme.convertNA(orange.train)

# Compute the average over the data and normalize it
orange.train.AVG <- dme.doAverage(orange.train.NA)

# Attach the labels to the data

#orange.train.labeled = dme.attachLabels(orange.train.AVG)

# Exporting data as .csv
# dme.exportCSV(orange.train.AVG, "ot_norm")

# Creating a data.frame of lables for the training set
labels <- dme.attachLabels()

### DAN's SVM Model ###
#svm.model = dmeTrainSVM(orange.train.AVG, labels$churn)


