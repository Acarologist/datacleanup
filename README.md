README: run_analysis.R
========================================================

The R script run_analysis.R is a function that will download & unzip the "Human Activity Recognition Using Smartphones" dataset from the following website:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It will then format and combine the test and training data present within into a tidy dataset, then calculate the mean of each remaining numeric variable for each subject and each activity.

It assumes that the test and train data are within folders inside a folder named "UCI HAR Dataset" within your working directory (i.e. the original structure of the unzipped .zip file has been preserved). If it does not find the data files in their expected folders within this folder, it will download the zipped dataset, and unzip it in your working director to the folder "UCI HAR Dataset" before proceeding with the creation of the tidy dataset. This will ensure that all data is present and in the correct location before the script begins. 

## Requirements
This function requires the **plyr library**. Please ensure that it is installed before proceeding.  
```
install.packages("plyr")
```

## Warnings
If you do not already possess the UCI HAR Dataset in a folder labeled "UCI HAR Dataset" within your working directly, the script will download the data. This data is nearly 60 MB in size and may take several minutes to download depending on your internet connection.   

Depending on the speed of your processor and the amount of available memory, the script may take several minutes to complete, even if the "UCI HAR Dataset" is present. Please be patient while the script runs.  

This script will output two datasets to memory:  
* tidy.clean: a large dataset of 10299 observations of 68 variables
* tidy.mean: a small dataset of 180 observations of 68 variables  

If your computer does not have sufficient memory to maintain both datasets in memory, please comment out `line 113` and `line 114` to prevent R from loading these datasets into memory.  

## Description of output files
In addition to loading the previously mentioned datasets into memory, the script will also produce two `.txt` files: `tidy.clean.txt` and `tidy.mean.txt` which correspond to the datasets listed above.  

* `tidy.clean.txt`: This is the output corresponding to step 4 of the course project. It contains the columns corresponding to the mean and standard deviation for each measurement of the merged test and training datasets (see the Code Book for additional details of the included columns). It also has columns corresponding to the subject and activity, with the activity column being a factor variable, possessing descriptive activity names (again, see the Code Book for details).

* `tidy.means.txt`: This is the output corresponding to step 5 of the course project. As with the `tidy.clean.txt` output, it also contains the descriptively names columns and activities, but instead of containing the raw data, instead contains the average of each variable for each activity and each subject (180 observations for each column.  

## How to read output data
The output files are .txt files that contain comma separated data. The dataframes within have headers and can be loaded into R using the read.csv() function.  
Example:  Read in the processed dataset containing the average of each variable for each activity and each subject (result of step 5 of the course project).  
```
tidy.means <- read.csv("tidy.means.txt")

# view first 6 rows and first 3 columns

tidy.means[1:6, 1:3]

#   subject           activity MeanOfTimeBodyAccelerationMeanX
# 1       1            walking                       0.2773308
# 2       1   walking_upstairs                       0.2554617
# 3       1 walking_downstairs                       0.2891883
# 4       1            sitting                       0.2612376
# 5       1           standing                       0.2789176
# 6       1             laying                       0.2215982
```  

## Licence
The run_analysis.R script is licensed under the GNU general public licence version 2. Please see the `LICENCE.txt` for details.

## Further information
Please see the related **`codebook.md`** document for further information. The `codebook.md` file contains information on the source of the data analysed, how the source data was processed, how the`tidy.clean` and `tidy.means` datasets were generated, as well as descriptions of the column names and their meanings.

For details on what exactly is done by run_analysis.R, please examine the code itself. I have extensively commented the code to ensure that it is clear what each part of the script is doing. 