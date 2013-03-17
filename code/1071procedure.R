
1071procedure <- function(func, train, test){
  library(e1071)
  library(hmeasure)
  
  classifier <- match.fun(func) 
  
  # Crossvalidation / Bootstrap settings
  tune.control <- tune.control(random =F, nrepeat=1, repeat.aggregate=min, sampling=c("cross"),
                               sampling.aggregate=mean, cross=5, best.model=T, performances=T)
  #obj.tune.churn <- tune('naiveBayes',churn~.,data=reducedTrain,tunecontrol = tune.control)
  
  # Training models
  print("[TRAINING] Churn")
  obj.model.churn <- classifier(churn ~ ., data=train, tunecontrol=tune.control)
  print("[TRAINING] Appetency")
  obj.model.app <- classifier(appetency ~ ., data=train, tunecontrol=tune.control)
  print("[TRAINING] Upselling")
  obj.model.up <- classifier(upselling ~ ., data=train, tunecontrol=tune.control)
  
  # Prediction on test set
  print("[PREDICTING] Churn")
  obj.pred.churn <- predict(obj.model.churn, test[,-which(colnames(test)=="churn")])
  print("[PREDICTING] Appetency")
  obj.pred.app <- predict(obj.model.app, test[,-which(colnames(test)=="appetency")])
  print("[PREDICTING] Upselling")
  obj.pred.up <- predict(obj.model.up, test[,-which(colnames(test)=="upselling")])
  
  # Confusion matrices
  print("[COMPUTING METRICS] Churn")
  obj.metrics.confusion.churn <- table(obj.pred.churn, test$churn)
  obj.metrics.accuracy.churn <- (obj.metrics.confusion.churn[1] + obj.metrics.confusion.churn[4]) / 
                                  sum(obj.metrics.confusion.churn)
  
  
  print("[COMPUTING METRICS] App")
  obj.metrics.confusion.app <- table(obj.pred.app, test$appetency)
  obj.metrics.accuracy.app <- (obj.metrics.confusion.app[1] + obj.metrics.confusion.app[4]) / 
                                sum(obj.metrics.confusion.app)
  
  print("[COMPUTING METRICS] Upselling")
  obj.metrics.confusion.up <- table(obj.pred.up, test$upselling)
  obj.metrics.accuracy.up <- (obj.metrics.confusion.up[1] + obj.metrics.confusion.up[4]) / 
                                sum(obj.metrics.confusion.up)
  
  #NB.rocr.churn <-prediction(NBModel.churn.pred, reducedTest$churn)
  #NB.perf.churn <-performance(NB.rocr.churn, measure = "tpr", x.measure = "fpr")
  #NB.auc.churn <- as.numeric(performance( NB.rocr.churn, measure = "auc", x.measure
                                        = "cutoff")@ y.values)
}
