# -- Importing train & test set -- #

## The function locates the data itself into the predefined document structure. 
#
# @data if the flag is set for TRUE, the function will return the data with the added columns
# @csv if the flat is set to TRUE, the data is exported into ../dataset/orange_small_train_labeled.csv

dme.exportData <- function(data, csv){

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
    
    if(csv=TRUE){
      print("[EXPORT] Exporting the trained labeled dataset as a .csv file...")
      write.csv(orange.train, "../dataset/orange_small_train_labeled.csv", row.names=FALSE)
      print("[EXPORT] Done exporting!")
      
    }

    if(data == TRUE){
      print("The data has been returned")
      return(orange.train)  
    }
    
}

