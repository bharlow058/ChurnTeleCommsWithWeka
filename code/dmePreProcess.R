# Imports the orange_small_train.data and adds the 3 labels to it
# 
# @data - boolean (if should return the combined data)
# @csv  - boolean (if the data should be exported to .csv)
# @binary - boolean (exports the data to a binary format)

dme.importData <- function(data, csv=FALSE, binary=FALSE){

    print("[IMPORT] Importing the train set into R as orange.train...")
    orange.train <- read.delim("../dataset/orange_small_train.data", header=TRUE, sep="\t", fill=TRUE)
    #str(orange.train)
    print("[IMPORT] Done!")

    
    # Export file to orange_small_train_labeled...
    
    if(csv == TRUE){
      print("[EXPORT] Exporting the trained labeled dataset as a .csv file...")
      write.csv(orange.train, "../dataset/orange_small_train_labeled.csv", row.names=FALSE)
      print("[EXPORT] Done exporting!\n")
      
    }
    
    if(binary == TRUE){
      cat("[EXPORT] Exporting the data to binary in var/...\n")
      save(orange.train, file='var/orange_train.Rda')
    }

    if(data == TRUE){
      print("The data has been returned\n")
      return(orange.train)  
    }
}

# Exports a data frame to a .arff file
#
# @data - data.frame (the data.frame to export)
# @name - string (the name of the file where the data will be exported)

dme.exportARFF <- function(data, name){
  name = paste("../dataset/Balanced/", name,".arff", sep="")
  library('foreign')
  write.arff(data, name)
  print(paste("[EXPORT] File written to: ",name, "\n",sep=""))
}


# Exports a data frame to a .csv file
#
# @data -  data.frame (the data.frame to export)
# @name -  string     (the name of the file where the data will be exported)

dme.exportCSV <- function(data,name){
  # paste concatenates strings together
  write.csv(orange.train, paste("../dataset/", name, ".csv", sep=""), row.names=FALSE)
  print(paste("[EXPORT] Data exported to: ", "../dataset/", name, ".csv\n", sep="")) 
}

# Import data.frame froma a .csv file
#
# @name - string (loads that filename - it must reside in ../dataset)
# @return - data.frame (returns a dataframe with the content of the file)

dme.importCSV <- function(name){
  print(paste("[IMPORT] Importing the", name, ".csv file..."))
  data.file <- read.delim(paste("../dataset/",name,".csv", sep=""), header=TRUE, sep="\t", fill=TRUE)  
  print("[IMPORT] Done!\n")
  return(data.file)
}

# Convert empty strings to NA
# Convert strings to integer values
#
# @orange.train.NA       - data.frame (the data.frame to preprocess)
# @binary     - boolean (exporting the data to a binary format)
# @return     - data.frame (returns the processed data.frame)
dme.convertNA <- function(orange.train.NA, binary=FALSE){
  
  print("[PREPROCESS] Cleaning out the data (NA,0)...")
  # Convert the '' to NA in the categorical attributes
	for(i in 191:230) {
		levels(orange.train.NA[[i]])[levels(orange.train.NA[[i]])==''] <- NA; # Convert '' to NA in cat. attr.
		orange.train.NA[[i]] <- as.integer(orange.train.NA[[i]]);	# Convert all cat. strings to int.
	}
  
  # For numeric values we are converting all of them to 0
	# orange.train.NA[is.na(orange.train.NA)] <- 0; # Convert all NA's to 0's
  print("[PREPROCESS] Data has been cleaned!\n")
  
  if(binary == TRUE){
    cat("[EXPORT] Exporting data to binary in var/...")
    save(orange.train.NA, file="var/orange_train_NA.Rda")
  }
  
	return(orange.train.NA);
}

# Group together categorical values that are infrequent
#
# @minCatFreq   - (minimum frequency of eligable categories, infrequent ones will be grouped together
dme.groupCats <- function(data, minCatFreq) {
  for(i in 191:230) {
    smallCats <- names(which(table(data[[i]]) < minCatFreq))
    if(length(smallCats) >= 1) {
      if(isTRUE(any(smallCats == 0))) {
        smallCats <- smallCats[-which(smallCats == 0)] # Avoid grouping empty values with infrequeny values
      }
      data[[i]] <- replace(data[[i]], which(data[[i]] %in% smallCats), smallCats[1])
    } 
  }
  return(data)
}

# Replace NAs with 0s
# Replace all numeric data which are 0 to the average
#
# @data   - data.frame ( the data.frame to preprocess)
# @range  - boolean (set to true if you want to also divide by the range)
# @binary - boolean (exporting the data to a binary format)
# @return - data.frame ( the data.frame with the mean replacing the zeros)

dme.doAverage <- function(orange.train.AVG, range=FALSE, binary=FALSE){
  
  orange.train.AVG[is.na(orange.train.AVG)] <- 0; # Convert all NA's to 0's
  
  print("[PREPROCESS] Normalizing the data by the mean...")
  for(i in 1:length(orange.train.AVG)){
    colmean <- mean(orange.train.AVG[,i])
    # we create an index of the column
    col.index <- matrix(data = orange.train.AVG[,i],nrow = 1,ncol = length(orange.train.AVG[,i]),byrow = TRUE);
    # we use the index to replace items in the index which match our condition
    orange.train.AVG[,i] <- replace(orange.train.AVG[,i], col.index == 0, colmean)
    
    # if we select range we also divide by the range
    if(range==TRUE){
      colrange <- (max(orange.train.AVG[,i]) - min(orange.train.AVG[,i]))
      orange.train.AVG[,i] <- (1/colrange) * orange.train.AVG[,i]
    }
  }
  
  if(range==TRUE){
      print("[PREPROCESS] Data normalised by the mean/range.\n")
    }else{
      print("[PREPROCESS] Data normalised by the mean.\n")
  }
  
  if(binary==TRUE){
    cat("[EXPORT] Exporting data to binary in var/...")
    save(orange.train.AVG, file='var/orange_train_AVG.Rda')
  }
  
  
  return(orange.train.AVG)
}

# Attach labels for the training set
#
# @data - data.frame (the labels are added to the data.frame)
# @return - data.frame (data.frame)

dme.attachLabels <- function(data){
    
  # Extracting the churn, appetency, upselling from the .label files
    
  print("[IMPORT] Importing .churn column to a new dataframe")
  train.churn <-read.delim("../dataset/orange_small_train_churn.labels", , header=FALSE, sep="\n", fill=FALSE)
  print("[IMPORT] Done importing churn!")
    
  print("[IMPORT] Importing .appetency column to a new dataframe")
  train.appetency <-read.delim("../dataset/orange_small_train_appetency.labels", , header=FALSE, sep="\n", fill=FALSE)
  print("[IMPORT] Done importing appetency!")
    
  print("[IMPORT] Importing .upselling column to a new dataframe")
  train.upselling <-read.delim("../dataset/orange_small_train_upselling.labels", , header=FALSE, sep="\n", fill=FALSE)
  print("[IMPORT] Done importing upselling")
      
  answer <- data.frame(churn=integer(50000), appetency=integer(50000), upselling=integer(50000))
  
  answer$churn <- train.churn[,]
  answer$appetency <- train.appetency[,]
  answer$upselling <- train.upselling[,]

  data$churn <- answer$churn
  data$appetency <- answer$appetency
  data$upselling <- answer$upselling

  return(data)
  
  #if(data == TRUE){
  #  print("The data has been returned\n")
  #  return(answer)  
  #}
}

dme.importTest <- function(data, csv=FALSE, binary=FALSE){
  print("[IMPORT] Importing the train set into R as orange.train...")
  orange.test <- read.delim("../dataset/orange_small_test.data", header=TRUE, sep="\t", fill=TRUE)
  #str(orange.train)
  print("[IMPORT] Done!")

    
  # Export file to orange_small_train_labeled...
    
  if(csv == TRUE){
    print("[EXPORT] Exporting the trained labeled dataset as a .csv file...")
    write.csv(orange.test, "../dataset/orange_small_test_labeled.csv", row.names=FALSE)
    print("[EXPORT] Done exporting!\n")
      
  }

  if(data == TRUE){
    print("The data has been returned\n")
    return(orange.test)  
  }
  
  if(binary == TRUE){
    cat("[EXPORT] Exporting data to binary in var/...")
    save(orange.test, file='var/orange_test.Rda')
  }
  
}

# Convert all categorical values to attributes that are added to the data frame
#
# @data       - data.frame (the data.frame to preprocess)
# @return     - data.frame (returns the processed data.frame with added attributes)
dme.convertCatsToAttr <- function(data) {
  for(i in 191:230) {
    cats <- names(table(data[[i]]))
    cat(i, "-", length(cats))
    if(length(cats) >= 3) {
      for(j in 3:length(cats)) {
        attrName <- paste("a",i,"c",cats[j])
        newAttr <- rep(0,dim(data)[1])
        newAttr[which(data[[i]] == cats[j])] <- 1
        data[[attrName]] <- newAttr
      }
      data[[i]] <- replace(data[[i]], which(data[[i]] > 1), 0)
    }
  }
  return(data)
}

# Convert all attributes to binary values
#
# @data       - data.frame (the data.frame to preprocess)
# @return     - data.frame (returns the processed data.frame binary attributes)
dme.convertToBinary <- function(data){
  print("[PREPROCESS] Converting data to binary...")
  for(i in 1:length(data)){
    print(i)
    # we create an index of the column
    col.index <- matrix(data = data[,i],nrow = 1,ncol = length(data[,i]),byrow = TRUE);
    # we use the index to replace items in the index which match our condition
    data[,i] <- replace(data[,i], col.index != 0, 1)
    
  }
  print("[PREPROCESS] Finished converting data to binary...")
  return(data)
}

# Split data and labels into balanced training and test sets
#
# @data       - data.frame (the data.frame to split in test and training set)
# @labels     - data.frame (the corresponding labels that are split in test and training)
# @return     - list (returns a list containing the data and labels for both train and test
#               To extract the elements from the list use the following: 
#                 trainData <- split[1]$TrainData
#                 testData <- split[2]$TestData
#                 trainLabels <- split[3]$TrainLabels
#                 testLabels <- split[4]$TestLabels)
dme.splitData <- function(data, labels) {
  print("[PREPROCESS] Splitting data to train and test...")
  classBalance <- cbind(length(which(labels == -1)), length(which(labels == 1))) / length(labels[,])
  
  posInd <- which(labels == 1)
  negInd <- which(labels == -1)

  set.seed(1234)
  posInd <- sample(posInd)
  negInd <- sample(negInd)

  posIndSplit <- floor(length(posInd) * 0.8)
  negIndSplit <- floor(length(negInd) * 0.8)

  trainInd <- cbind(t(posInd[1:posIndSplit]), t(negInd[1:negIndSplit]))
  testInd <- cbind(t(posInd[(posIndSplit+1):length(posInd)]), t(negInd[(negIndSplit+1):length(negInd)]))

  trainData <- data[trainInd,]
  testData <- data[testInd,]
  trainLabels <- factor(labels[trainInd])
  testLabels <- factor(labels[testInd])

  print("[PREPROCESS] Finished splitting data to train and test")
  list(TrainData=trainData, TestData=testData, TrainLabels=trainLabels, TestLabels=testLabels)
}

dme.attachLabelsToData <- function(data, labels) {
  data$churn = labels$churn
  data$appetency = labels$appetency
  data$upselling = labels$upselling
  return (data)
}

