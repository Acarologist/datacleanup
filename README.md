README: run_analysis.R
========================================================
Author: Alexander Smith, PhD

The R script run_analysis.R is a function that will download & unzip the "Human Activity Recognition Using Smartphones" dataset from the following website:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It will then format and combine the test and training data present within into a tidy dataset, then calculate the mean of each remaining numeric variable for each subject and each activity.

It assumes that the test and train data are within folders inside a folder named "UCI HAR Dataset" within your working directory (i.e. the original structure of the unzipped .zip file has been preserved). If it does not find the data files in their expected folders within this folder, it will download the zipped dataset, and unzip it in your working director to the folder "UCI HAR Dataset" before proceeding with the creation of the tidy dataset. This will ensure that all data is present and in the correct location before the script begins. 

## 1. Requirements
This function requires the **plyr library**. Please ensure that it is installed before proceeding.  
```
install.packages("plyr")
```

## 2. Warnings
If you do not already possess the UCI HAR Dataset in a folder labeled "UCI HAR Dataset" within your working directly, the script will download the data. This data is nearly 60 MB in size and may take several minutes to download depending on your internet connection.   

Depending on the speed of your processor and the amount of available memory, the script may take several minutes to complete, even if the "UCI HAR Dataset" is present. Please be patient while the script runs.  

This script will output two datasets to memory:  
* tidy.clean: a large dataset of 10299 observations of 68 variables
* tidy.mean: a small dataset of 180 observations of 68 variables  

If your computer does not have sufficient memory to maintain both datasets in memory, please comment out `line 115` and `line 116` to prevent R from loading these datasets into memory.  

## 3. Description of output files
In addition to loading the previously mentioned datasets into memory, the script will also produce two `.txt` files: `tidy.clean.txt` and `tidy.mean.txt` which correspond to the datasets listed above.  

* `tidy.clean.txt`: This is the output corresponding to step 4 of the course project. It contains the columns corresponding to the mean and standard deviation for each measurement of the merged test and training datasets (see the Code Book for additional details of the included columns). It also has columns corresponding to the subject and activity, with the activity column being a factor variable, possessing descriptive activity names (again, see the Code Book for details).

* `tidy.means.txt`: This is the output corresponding to step 5 of the course project. As with the `tidy.clean.txt` output, it also contains the descriptively names columns and activities, but instead of containing the raw data, instead contains the average of each variable for each activity and each subject (180 observations for each column.  

## 4. How to read output data
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

## 5. Processing of the the raw data
### 5.1 Adding appropriate column names to each dataset
Column names were not included as part of each of the original datasets, instead this data was included in a separate `features.txt` file. These descriptions were not in an "R friendly" format originally (containing characters that perform specific functions within R). Thus, all problematic characters such as parentheses, dashes, and commas were removed. Additionally the text of each label was expanded to make it more descriptive.  

Please see **section 3** of the **`codebook.md`** file for details on the variable names, their meanings, how they were chosen, and an explanation of the choices made when developing the names given.  

### 5.2 Adding subject and activity data to the test and train datasets
Both the test and train datasets were each read into R, and the appropriate subject labels and activity labels bound to the left side of each dataset. Each was given an appropriate, descriptive column name: "subject" and "activity" respectively.  

Please see **sections 2.2.1 and 2.2.2** for details on exactly what was done to obtain the "subject" and "activity" columns and labels.  

### 5.3 Combining the test and training datasets and subsetting the result
Details of this process are given in the **`codebook.md`** file (see **sections 2.3 and 2.4**), however a brief summary is provided here. The run_analysis.R script, recombines two datasets (`X_test.txt` and `X_train.txt`) into a single dataset after having the subject and activity labels added to each.  

Following this, a subset of this dataset that only contains the variables containing `mean` or `standard deviation` data was taken. The details of this process are found in **section 2.4** of the **`codebook.md`**. This reduced the number of columns from 563 to 68. The resulting dataset (`tidy.clean`) contains 2 identification columns ("subject" and "activity"), and 66 numeric variable columns).  

### 5.4 Calculating the average of the numeric columns by both subject and activity
The average (mean) value of each of the numeric columns present in the `tidy.clean` dataset was calculated, for each subject and each activity. The resultant dataset (`tidy.mean`) consists of 180 observations (`30 subjects * 6 activities = 180`), and 68 variables ("subject", "activity", and 66 numeric variables). Additional information about this process can be found in **section 2.5** of the **`codebook.md`**, and lists of all columns present in the `tidy.clean` and `tidy.means` datasets are given in **Appendix 1** in the **`codebook.md`**. 

## 6. Licence
The run_analysis.R script is licensed under the GNU general public licence version 2. Please see the `LICENCE.txt` for details.

## 7. Further information
Please see the related **`codebook.md`** document for further information. The `codebook.md` file contains information on the source of the data analysed, how the source data was processed, how the`tidy.clean` and `tidy.means` datasets were generated, as well as descriptions of the column names and their meanings.

For details on what exactly is done by run_analysis.R, please examine the code itself. I have extensively commented the code to ensure that it is clear what each part of the script is doing. 