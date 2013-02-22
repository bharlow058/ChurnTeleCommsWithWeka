# Imports the orange_small_train.data and adds the 3 labels to it
# 
# @data - boolean (if should return the combined data)
# @csv  - boolean (if the data should be exported to .csv)

dme.importData <- function(data, csv){

    print("[IMPORT] Importing the train set into R as orange.train...")
    orange.train <- read.delim("../dataset/orange_small_train.data", header=TRUE, sep="\t", fill=TRUE)
    #str(orange.train)
    print("[IMPORT] Done!")
    
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
    
    orange.train$churn <- train.churn[,]
    orange.train$appatency <- train.appatency[,]
    orange.train$upselling <- train.upselling[,]
    
    # Export file to orange_small_train_labeled...
    
    if(csv == TRUE){
      print("[EXPORT] Exporting the trained labeled dataset as a .csv file...")
      write.csv(orange.train, "../dataset/orange_small_train_labeled.csv", row.names=FALSE)
      print("[EXPORT] Done exporting!")
      
    }

    if(data == TRUE){
      print("The data has been returned")
      return(orange.train)  
    }
}

# Exports a data frame to a .csv file
#
# @data -  data.frame (the data.frame to export)
# @name -  string     (the name of the file where the data will be exported)

dme.exportCSV <- function(data,name){
  # paste concatenates strings together
  write.csv(orange.train, paste("../dataset/", name, ".csv", sep=""), row.names=FALSE)
  print(paste("[EXPORT] Data exported to: ", "../dataset/", name, ".csv", sep="")) 
}

# Import data.frame froma a .csv file
#
# @name - string (loads that filename - it must reside in ../dataset)
# @return - data.frame (returns a dataframe with the content of the file)

dme.importCSV <- function(name){
  print(paste("[IMPORT] Importing the", name, ".csv file..."))
  data.file <- read.delim(paste("../dataset/",name,".csv", sep=""), header=TRUE, sep="\t", fill=TRUE)  
  print("[IMPORT] Done!")
  return(data.file)
}

# Convert all data values which are NA to 0
#
# @data - data.frame (the data.frame to preprocess)
# @return - data.frame (returns the processed data.frame)

dme.convertNA <- function(data){
  
  # Convert the '' to NA in the categorical attributes
	for(i in 191:230) {
		levels(data[[i]])[levels(data[[i]])==''] <- NA; # Convert '' to NA in cat. attr.
		data[[i]] <- as.integer(data[[i]]);	# Convert all cat. strings to int.
	}
  
  # For numeric values we are converting all of them to 0
	data[is.na(data)] <- 0; # Convert all NA's to 0's
	return(data);
}

# Replace all numeric data which are 0 to the average
# @data - data.frame ( the data frame to preprocess)

dme.doAverage <- function(data){
  
}














