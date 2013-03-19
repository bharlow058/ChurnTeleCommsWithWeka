# Constructing formulas for all categories we want to predict
varsComplete <- paste("Var", 1:230, sep="")

fmlaChurn     <- as.formula(paste("churn ~ ",     paste(varsComplete, collapse= "+")))
fmlaAppetency <- as.formula(paste("appetency ~ ", paste(varsComplete, collapse= "+")))
fmlaUpselling <- as.formula(paste("upselling ~ ", paste(varsComplete, collapse= "+")))


# Feature selection using cfs
library(FSelector, lib.loc="/afs/inf.ed.ac.uk/user/s12/s1255964/programs/Rpackages/");
# unprocessed data
features.data.unprocessed.churn     <- cfs(fmlaChurn,     orange.train.NA.labels);
features.data.unprocessed.appetency <- cfs(fmlaAppetency, orange.train.NA.labels);
features.data.unprocessed.upselling <- cfs(fmlaUpselling, orange.train.NA.labels);

features.data.unprocessed <- union(features.data.unprocessed.churn,
                                   union(features.data.unprocessed.appetency,
                                         features.data.unprocessed.upselling));
orange.train.reduced.unprocessed <- orange.train.NA.labels[, union(features.data.unprocessed,c("churn","appetency","upselling"))]

orange.train.reduced.unprocessed.churn <-orange.train.NA.labels[, union(features.data.unprocessed.churn,c("churn"))]
orange.train.reduced.unprocessed.appetency <-orange.train.NA.labels[, union(features.data.unprocessed.appetency,c("appetency"))]
orange.train.reduced.unprocessed.upselling <-orange.train.NA.labels[, union(features.data.unprocessed.upselling,c("upselling"))]


# pre-processed data
features.data.processed.churn     <- cfs(fmlaChurn,     orange.train.AVG.labels);
features.data.processed.appetency <- cfs(fmlaAppetency, orange.train.AVG.labels);
features.data.processed.upselling <- cfs(fmlaUpselling, orange.train.AVG.labels);

features.data.processed <- union(features.data.processed.churn,
                                 union(features.data.processed.appetency,
                                       features.data.processed.upselling));
orange.train.reduced.processed <- orange.train.AVG.labels[, union(features.data.processed,c("churn","appetency","upselling"))]

orange.train.reduced.processed.churn <- orange.train.AVG.labels[, union(features.data.processed.churn,c("churn"))]
orange.train.reduced.processed.appetency <- orange.train.AVG.labels[, union(features.data.processed.appetency,c("appetency"))]
orange.train.reduced.processed.upselling <- orange.train.AVG.labels[, union(features.data.processed.upselling,c("upselling"))]

# exporting to ARFF
dme.exportARFF(orange.train.reduced.unprocessed.churn , "churnReducedUnprocessedTrain");
dme.exportARFF(orange.train.reduced.unprocessed.appetency , "appetencyReducedUnprocessedTrain");
dme.exportARFF(orange.train.reduced.unprocessed.upselling , "upsellingReducedUnprocessedTrain");


dme.exportARFF(orange.train.reduced.processed.churn,   "churnReducedProcessedTrain")
dme.exportARFF(orange.train.reduced.processed.appetency,   "appetencyReducedProcessedTrain")
dme.exportARFF(orange.train.reduced.processed.upselling,   "upsellingReducedProcessedTrain")
