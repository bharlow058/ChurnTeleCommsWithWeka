# Crossvalidation / Bootstrap settings
tune.control <- tune.control(random =F, nrepeat=1, repeat.aggregate=min, sampling=c("boot"),
                             sampling.aggregate=mean, cross=5, best.model=T, performances=T)
#NBtune <- tune('naiveBayes',churn~.,data=reducedTrain,tunecontrol = tune.control)

# Training models
NB.model.churn <- naiveBayes(churn ~ .,data=train,tunecontrol=tune.control)
NB.model.app <- naiveBayes(appetency ~ .,data=train,tunecontrol=tune.control)
NB.model.up <- naiveBayes(upselling ~ .,data=train,tunecontrol=tune.control)

# Prediction on test set
NB.pred.churn <- predict(NBModel.churn,test[,-which(colnames(reducedTest)=="churn")])
NB.pred.app <- predict(NBModel.app,test[,-which(colnames(reducedTest)=="appetency")])
NBModel.pred.up <- predict(NBModel.up,test[,-which(colnames(reducedTest)=="upselling")])

# Confusion matrices
table(NBModel.churn.pred,reducedTest$churn)
table(NBModel.app.pred,reducedTest$appetency)
table(NBModel.up.pred,reducedTest$upselling)