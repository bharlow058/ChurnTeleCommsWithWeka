library(rpart)

vars <- paste("Var", 1:50, sep="")
fmla <- as.formula(paste("churn ~ ", paste(vars, collapse= "+")))

churnFit = rpart(fmla, data = orange.train.labels, control = rpart.control(cp = 0.001))
churnNAFit = rpart(fmla, data = orange.train.NA.labels, control = rpart.control(cp = 0.001))
churnAvgFit = rpart(fmla, data = orange.train.AVG.labels, control = rpart.control(cp = 0.001))

varsComplete <- paste("Var", 1:230, sep="")
fmlaComplete <- as.formula(paste("churn ~ ", paste(varsComplete, collapse= "+")))

churnCompleteFit <- rpart(fmlaComplete, data = orange.train.labels, control = rpart.control(cp = 0.001))

churnFit2 = rpart(fmla, data = orange.train.labels, control = rpart.control(cp = 0.0001))