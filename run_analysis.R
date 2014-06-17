run_analysis <- function() {
    # Load required library
    require(plyr)
    ## Only get data if file does not exist
    if(!file.exists("UCI HAR Dataset/test/X_test.txt")) {
        ## Detect OS to determine which download method to use
        if(.Platform$OS.type == "windows") {
            ## Download data:
            download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                          destfile = "data.zip", mode = "wb")
        } else {
            download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                          destfile = "data.zip", method = "curl", mode = "wb")
        }
        # Unzip file, this will give you the folder "UCI HAR Dataset" 
        # in your working directory
        unzip("data.zip")
    }
    # Read in activity factors and features
    feature <- readLines("UCI HAR Dataset/features.txt")
    activity <- readLines("UCI HAR Dataset/activity_labels.txt")
    
    # Convert list of activities to lowercase, and remove numbers
    activity2.split <- strsplit(tolower(activity), " ")
    activity.element <- sapply(activity2.split, function(x) x[2])
    
    # Convert list of features into descriptive column names
    # Remove R unfriendly characters and numbers
    feat2 <- gsub("-|,|\\(|\\)", "", feature)
    
    feat2.split <- strsplit(feat2, " ")
    feat3 <- sapply(feat2.split, function(x) x[2])
    
    # Convert abbreviated names to verbose, 'descriptive' names
    feat4 <- sub("^t", "Time", feat3)
    feat4 <- sub("^f", "Frequency", feat4)
    feat4 <- sub("Acc", "Accelerometric", feat4)
    feat4 <- sub("Gyro", "Gyroscopic", feat4)
    feat4 <- sub("mean", "Mean", feat4)
    feat4 <- sub("std", "StdDev", feat4)
    feat4 <- sub("Mag", "Magnittude", feat4)
    feat4 <- sub("BodyBody", "Body", feat4)
    
    # Read in the test data files
    test.x <- read.table("UCI HAR Dataset/test/X_test.txt", header = F, 
                         sep = "", quote = "", stringsAsFactors = F)
    test.y <- read.table("UCI HAR Dataset/test/y_test.txt", header = F, 
                         sep = "", quote = "", stringsAsFactors = F,
                         col.names = "activity")
    test.sub <- read.table("UCI HAR Dataset/test/subject_test.txt", header = F, 
                           sep = "", quote = "", stringsAsFactors = F,
                           col.names = "subject")
    
    # Make features into column names for test.x dataset
    colnames(test.x) <- feat4
    
    # Convert activity factors into descriptive names for test.y
    test.y[, 1] <- as.factor(test.y[, 1])
    levels(test.y[, 1]) <- activity.element
    
    # Combine the test data files
    test.full <- cbind(test.sub, test.y, test.x)
    
    # Read in the train data files
    train.x <- read.table("UCI HAR Dataset/train/X_train.txt", header = F, 
                         sep = "", quote = "", stringsAsFactors = F)
    train.y <- read.table("UCI HAR Dataset/train/y_train.txt", header = F, 
                         sep = "", quote = "", stringsAsFactors = F,
                         col.names = "activity")
    train.sub <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            header = F, sep = "", quote = "", 
                            stringsAsFactors = F, col.names = "subject")
    
    # Make features into column names for train.x dataset
    colnames(train.x) <- feat4
    
    # Convert activity factors into descriptive names for train.y
    train.y[, 1] <- as.factor(train.y[, 1])
    levels(train.y[, 1]) <- activity.element
    
    # Combine the train data files
    train.full <- cbind(train.sub, train.y, train.x)
    
    # Combine the test.full and train.full datasets
    tidy1 <- rbind(test.full, train.full)
    
    # Determine which columns contain mean or standard deviations as well as 
    # the subject (col1) and activity (col2)
    gmeanstd <- c(1, 2, grep("Mean|StdDev", names(tidy1)))
    
    # Remove the columns corresponding to MeanFreq or angle
    gmeanf <- grep("MeanFreq|angle", names(tidy1))
    gmean.clean <- gmeanstd[ - which(gmeanstd %in% gmeanf)]
    
    # Take the subset of the dataframe that corresponds to the means and
    # standard deviations only
    tidy2 <- tidy1[, gmean.clean]
    
    # Determine the mean of all columns by subject and activity using ddply
    tidy.plyr <- ddply(tidy2, 1:2, function(x) colMeans(x[3:68]))
    
    # rename columns to indicate are now means of these values
    colnames(tidy.plyr) <- c("subject", "activity", 
                             paste0("MeanOf", names(tidy.plyr[, 3:68])))
    
    # write tables of 'raw' (tidy.clean) and processed data (tidy.means)
    write.table(tidy2, file = "tidy.clean.txt", sep = ",")
    write.table(tidy.plyr, file = "tidy.means.txt", sep = ",")
    
    # return cleaned data containing the raw measurments of means and standard
    # deviations (tidy.clean), as well as the tidy dataset consisting of the 
    # calculated means of all columns to memory, for further use.
    tidy.clean <<- tidy2     ## comment line out to prevent loading into memory
    tidy.means <<- tidy.plyr ## comment line out to prevent loading into memory
}