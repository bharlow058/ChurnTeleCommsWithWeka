
# -- Pre-processing dataset -- #

# The function fills in 0's for all missing values and transforms
# categorical attributes to numeric. Categories are represented with integers >= 1.
preProcess <- function(data) {
	for(i in 191:230) {
		levels(data[[i]])[levels(data[[i]])==''] <- NA; # Convert '' to NA in cat. attr.
		data[[i]] <- as.integer(data[[i]]);	# Convert all cat. strings to int.
	}
	data[is.na(data)] <- 0; # Convert all NA's to 0's
	return(data);
}

# TO-DO: Convert all attributes to binary by converting all numerics > 0 to 1
#		 and make each value in the cat. attr. a new attribute. 

# Random stuff:
# write.csv(train, "../dataset/trainNumeric.csv", row.names=FALSE)
# write.csv(test, "../dataset/testNumeric.csv", row.names=FALSE)
#names(table(train$Var191));
#catNum <- factor(names(table(train$Var191)));
#as.integer(catNum);
#categories <- factor(names(table(train$Var191)), levels=names(table(train$Var191)))