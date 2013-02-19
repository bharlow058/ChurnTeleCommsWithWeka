# Importing the data to R

# -- Importing train & test set

print("[IMPORT] Importing the train set into R as orange.train...")
orange.train <- read.delim("../dataset/orange_small_train.data", header=TRUE, sep="\t", fill=TRUE)
str(orange.train)
print("[IMPORT] Done!")

print("[IMPORT] Importing the test set into R as orange.test...")
orange.test  <- read.delim("../dataset/orange_small_test.data", header=TRUE, sep="\t", fill=TRUE)
str(orange.train)
print("[IMPORT] Done!")

#TODO - need to clean categorical data from the dataset
# asdasdasd



