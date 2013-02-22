# Imports the orange_small_train.data and adds the 3 labels to it
# 
# @data - boolean (if should return the combined data)
# @csv  - boolean (if the data should be exported to .csv)

dme.importData <- function(data, csv=FALSE){

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
  name = paste("../dataset/", name,".arff", sep="")
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

# Convert all data values which are NA to 0
#
# @data       - data.frame (the data.frame to preprocess)
# @groupCats  - boolean (TRUE -> group infrequent categorical values together)
# @minGroup   - (minimum size of eligable categories, others will be grouped if groupCats == TRUE)
# @return     - data.frame (returns the processed data.frame)

dme.convertNA <- function(data, groupCats, minGroup){
  
  print("[PREPROCESS] Cleaning out the data (NA,0)...")
  # Convert the '' to NA in the categorical attributes
	for(i in 191:230) {

    if(isTRUE(groupCats)) {
      smallCats <- names(which(table(data[[i]]) < minGroup))
      if(length(smallCats) >= 1) {
        if(isTRUE(any(smallCats == ''))) {
          smallCats <- smallCats[-which(smallCats == '')] # Avoid grouping empty values with infrequeny values
        }
        data[[i]] <- replace(data[[i]], which(data[[i]] %in% smallCats), smallCats[1])
      } 
    }

		levels(data[[i]])[levels(data[[i]])==''] <- NA; # Convert '' to NA in cat. attr.
		data[[i]] <- as.integer(data[[i]]);	# Convert all cat. strings to int.
	}
  
  # For numeric values we are converting all of them to 0
	data[is.na(data)] <- 0; # Convert all NA's to 0's
  print("[PREPROCESS] Data has been cleaned!\n")
	return(data);
}

# Replace all numeric data which are 0 to the average
#
# @data   - data.frame ( the data.frame to preprocess)
# @range  - boolean (set to true if you want to also divide by the range)
# @return - data.frame ( the data.frame with the mean replacing the zeros)

dme.doAverage <- function(data, range=FALSE){
  
  print("[PREPROCESS] Normalizing the data by the mean...")
  for(i in 1:length(data)){
    colmean <- mean(data[,i])
    # we create an index of the column
    col.index <- matrix(data = data[,i],nrow = 1,ncol = length(data[,i]),byrow = TRUE);
    # we use the index to replace items in the index which match our condition
    data[,i] <- replace(data[,i], col.index == 0, colmean)
    
    # if we select range we also divide by the range
    if(range==TRUE){
      colrange <- (max(data[,i]) - min(data[,i]))
      data[,i] <- (1/colrange) * data[,i]
    }
  }
  
  if(range==TRUE){
      print("[PREPROCESS] Data normalised by the mean/range.\n")
    }else{
      print("[PREPROCESS] Data normalised by the mean.\n")
  }
  
  return(data)
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
    
  print("[IMPORT] Importing .churn column to a new dataframe")
  train.appatency <-read.delim("../dataset/orange_small_train_appetency.labels", , header=FALSE, sep="\n", fill=FALSE)
  print("[IMPORT] Done importing churn!")
    
  print("[IMPORT] Importing .churn column to a new dataframe")
  train.upselling <-read.delim("../dataset/orange_small_train_upselling.labels", , header=FALSE, sep="\n", fill=FALSE)
  print("[IMPORT] Done importing churn!")
    
  data$churn <- train.churn[,]
  data$appatency <- train.appatency[,]
  data$upselling <- train.upselling[,]
  
  if(data == TRUE){
    print("The data has been returned\n")
    return(data)  
  }
  
}




