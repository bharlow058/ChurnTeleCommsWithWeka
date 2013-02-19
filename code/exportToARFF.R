orange.train$appetency <- read.delim("../dataset/orange_small_train_appetency.labels", header=FALSE, sep="\n", fill=FALSE);
library(foreign);
write.arff(orange.train,"../dataset/orangeTrain.arff");