# UNFINISHED!
nbClassifier <- function(training, labels, test) {
	print("Converting to matrices...")
	labels <- data.matrix(labels)
	training <- data.matrix(training)
	test <- data.matrix(test)
	print("...Finished converting!")

	print("Training model...")
	negLabels <- (1-labels) / 2; # Neg. labels = 1, Pos. labels = 0 
	posLabels <- (1+labels) / 2; # Pos. labels = 1, Neg. labels = 0 
	N_c <- c(sum(negLabels), sum(posLabels)); # Number of neg. and pos. labels
	# Weird things happening ->
	N_jc <- c(t(negLabels) %*% training, t(posLabels) %*% training);
	epsilon <- 0.0000000001; # Add noise
	logpi <- N_c / sum(N_c); # Prior prob. of each label
	logtheta <- (N_jc / N_c) + epsilon;
	print("... Finished training model!")

	print("Predicting labels on test data...")
	L_ic <- matrix(0, dim(training)[1], 2);
	for(i in 1:2) {
		L_ic[,i] <- logpi[i];
		L_ic[,i] <- L_ic[,i] + colSums(log(1 - logtheta[,i]));
		L_ic[,i] <- L_ic[,i] + training %*% log(logtheta[,i]) - training $*$ log(1 - logtheta[,i]);
	}
	p_ic <- c(exp(L_ic[,0] - log(exp(L_ic[,0] + L_ic[,1]))),
				exp(L_ic[,1] - log(exp(L_ic[,0] + L_ic[,1]))));
	y_hat <- which(apply(p_ic,1,max) == p_ic)
	print("...Finished predicting!")
}