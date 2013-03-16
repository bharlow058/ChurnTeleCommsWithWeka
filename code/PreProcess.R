varsComplete <- paste("Var", 1:230, sep="")
fmlaComplete <- as.formula(paste("churn ~ ", paste(varsComplete, collapse= "+")))

library(FSelector); # lib.loc="/afs/inf.ed.ac.uk/user/s12/s1255964/programs/Rpackages/");

# Feature Ranking Method for feature selection
# Only few attributes with big values
weights_chi    <- chi.squared(fmlaComplete, orange.train.AVG.labels);
weights_infoGain <- information.gain(fmlaComplete, orange.train.AVG.labels);
weights_gainRation <- gain.ratio(fmlaComplete, orange.train.AVG.labels); # Returns NaNs
weigths_sym <- symmetrical.uncertainty(fmlaComplete, orange.train.AVG.labels);

# Lots of attributes with small values
weights_linear <- linear.correlation(fmlaComplete, orange.train.AVG.labels);
weights_Spearman <- rank.correlation(fmlaComplete, orange.train.AVG.labels);

features1 <- cutoff.k(weights_chi, 6);

# Subset Selection Method for feature selection 
features2 <- cfs(fmlaComplete, orange.train.AVG.labels);