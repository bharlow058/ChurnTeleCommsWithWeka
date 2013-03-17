varsComplete <- paste("Var", 1:230, sep="")

# Constructing formula for the churn feature
fmlaChurn <- as.formula(paste("churn ~ ", paste(varsComplete, collapse= "+")))

library(FSelector); # lib.loc="/afs/inf.ed.ac.uk/user/s12/s1255964/programs/Rpackages/");

# Feature Ranking Method for feature selection
# Returns only few attributes with big values
weights_chi    <- chi.squared(fmlaChurn, orange.train.AVG.labels);
weights_infoGain <- information.gain(fmlaChurn, orange.train.AVG.labels);
weights_gainRation <- gain.ratio(fmlaChurn, orange.train.AVG.labels); # Returns NaNs
weigths_sym <- symmetrical.uncertainty(fmlaChurn, orange.train.AVG.labels);

# Returns lots of attributes with small values
weights_linear <- linear.correlation(fmlaChurn, orange.train.AVG.labels);
weights_Spearman <- rank.correlation(fmlaChurn, orange.train.AVG.labels);

# Features corresponding to highest values of weights
features1 <- cutoff.k(weights_chi, 6);

# Subset Selection Method for feature selection 
# These methods should return higher quality subsets of features than the previous ones
features2 <- cfs(fmlaChurn, orange.train.AVG.labels);

# Principal Component Analysis
orange.train.AVG_pca <- prcomp(orange.train.AVG)

# Rotation matrix: rows = PC components, columns = Vars
principalFeature <- as.matrix(orange.train.AVG) * orange.train.AVG_pca$rotation[,1];

