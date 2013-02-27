# UNFINISHED!
nbClassifier <- function(train, labels, test) {
	print("Converting to matrices...")
	labels <- data.matrix(labels)
	train <- data.matrix(train)
	test <- data.matrix(test)
	print("...Finished converting!")

	print("Training model...")
	negLabels <- (1-labels) / 2; # Neg. labels = 1, Pos. labels = 0 
	posLabels <- (1+labels) / 2; # Pos. labels = 1, Neg. labels = 0 
	N_c <- c(sum(negLabels), sum(posLabels)); # Number of neg. and pos. labels
	# Weird things happening ->
	N_jc <- cbind(t(t(negLabels) %*% train), t(t(posLabels) %*% train));
	epsilon <- 0.0000000001; # Add noise
	logpi <- N_c / sum(N_c); # Prior prob. of each label
	logtheta <- (N_jc / N_c) + epsilon;
	logtheta[which(logtheta >= 1)] <- 0.999999
	print("... Finished training model!")

	print("Predicting labels on test data...")
	L_ic <- matrix(0, dim(test)[1], 2);
	for(i in 1:2) {
		L_ic[,i] <- logpi[i];
		L_ic[,i] <- L_ic[,i] + sum(log(1 - logtheta[,i]));
		L_ic[,i] <- L_ic[,i] + test %*% log(logtheta[,i]) - test %*% log(1 - logtheta[,i]);
	}
	p_ic <- cbind(exp(L_ic[,1] - log(exp(L_ic[,1] + L_ic[,2]))),
				exp(L_ic[,2] - log(exp(L_ic[,1] + L_ic[,2]))));

	p_ic <- cbind(exp(L_ic[,1] - log(sum(exp(L_ic[,1] - max(L_ic[,1])), 
								exp(L_ic[,2] - max(L_ic[,2])))) + max(L_ic[,1]) + max(L_ic[,2])),
			exp(L_ic[,2] - log(sum(exp(L_ic[,1] - max(L_ic[,1])), 
								exp(L_ic[,2] - max(L_ic[,2])))) + max(L_ic[,1]) + max(L_ic[,2])))

	y_hat <- apply(p_ic,1,which.max)
	y_hat[which(y_hat == 1)] <- -1
	y_hat[which(y_hat == 2)] <- 1
	table(pred = y_hat, true = train.churn[,1])
	print("...Finished predicting!")
	return(y_hat)
}