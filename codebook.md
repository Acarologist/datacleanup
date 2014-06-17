Code book: run_analysis.R
========================================================

This is the code book associated with the run_analysis.R script. It contains information about the data analyzed by the run_analysis.R script, and how the data was analyzed. 

## 1. Description of the source Data used
The data used in the related script comes from the "Human Activity Recognition Using Smartphones Dataset Version 1.0" (hereafter "UCI HAR dataset". This data set was produced by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto. At Smartlab - Non Linear Complex Systems Laboratory, at DITEN - Università degli Studi di Genova.  
Address: Via Opera Pia 11A, I-16145, Genoa, Italy.  
Email: activityrecognition@smartlab.ws  
Website: www.smartlab.ws  

Please note that the following description of the original data comes from the `README.txt` and `features_info.txt` files present in the UCI HAR dataset. The text has been modified very slightly, but is block quoted to make it clear that this is the work of the original dataset authors and that no credit is being taken for their work. 

> > The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, and laying down) while wearing a smartphone (Samsung Galaxy S II) on their waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> > The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

> > The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> > Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. Finally a Fast Fourier Transform (FFT) was applied to some of these signals.

## 2. Processing of the the raw data
### 2.1 Adding appropriate column names to each dataset
Column names were not included as part of each of the original datasets, instead this data was included in a separate `features.txt` file. These descriptions were not in an "R friendly" format originally (containing characters that perform specific functions within R). Thus, all problematic characters such as parentheses, dashes, and commas were removed. Additionally the text of each label was expanded to make it more descriptive.  

Please see **section 3** below on variable labels for details on the variable names, their meanings, how they were chosen, and an explanation of the choices made when developing the names given. 

### 2.2 Adding subject and activity data to the test and train datasets
Both the test and train datasets were each read into R, and the appropriate subject labels and activity labels bound to the left side of each dataset. Each was given an appropriate, descriptive column name: "subject" and "activity" respectively.

#### 2.2.1 Subjects  
The subject id data was obtained from the `subject_test.txt` or `subject_train.txt` files as appropriate. There are 30 subjects, labeled 1 - 30.

#### 2.2.2 Activities  
The activity labels were obtained from the `y_test.txt` or `y_train.txt` files as appropriate. The numeric activity labels were converted to factors, and factor labels applied using the `activity_labels.txt` file. There are 6 activity factors:
* walking (1)  
* walking_upstairs (2)  
* walking_downstairs (3)  
* sitting (4)  
* standing (5)
* laying (6)  

The number in parentheses corresponds to the factor level listed in the `y_test.txt` and `y_train.txt` files.

### 2.3 Combining the test and training datasets
As described above, the original raw data was divided into two datasets. As part of the run_analysis.R script, these two datasets (`X_test.txt` and `X_train.txt`) were recombined into a single dataset after having the subject and activity labels added to each. 

### 2.4 Selection of a subset of the combined dataset
As part of the analysis, only variables containing `mean` or `standard deviation` data were desired for further analysis. To accomplish this, only columns containing the string "Mean" or "StdDev" (following processing of the label names as per **section 3**) in their labels were kept, reducing the number of columns from 563 to 68 (2 identification columns ("subject" and "activity"), and 66 numeric variable columns). 

**Note:** These values were chosen, and the columns containing the `meanFreq` and `angle` data were discarded due to the fact that the instructions for this assignment indicated to take only the measurements on the mean and standard deviation for each measurement. Because both the `meanFreq` data consisted of a weighted average of the frequency data, and the `angle` data measured the angle between two vectors, I chose to exclude them from the analysis. This left only the mean and standard deviation values for the remaining 33 feature variables (for a total of 66 numeric variables). 

## 3. Variable (feature) labels of the tidy datasets
### 3.1 Explaination of labelling choices
The variable labels were converted to sentence case, without spaces as a compromise between readability and convenience of reference within R. Although many prefer labels to be in all lowercase, it is my opinion that sentence case makes distinguishing between the words of the label much easier, particularly when very long variable names are used. Underscores and spaces were avoided in the labels to minimize typing if one needs to reference a particular variable in downstream analyses. I personally find these expanded names to be awkward and unwieldy, and were this analysis for my personal use, I would have kept the original feature descriptions (after removing the R unfriendly characters). However, as the course project requirements state to make the names descriptive, I have done so.

**Note 1:** The string **"BodyBody"** present in some feature names (derived from the original features.txt file) was replaced by the string **"Body"**, to match the description given in the original `features_info.txt` file.) It appears that the string "BodyBody" was a typo in the original features list. 

**Note 2:** The string **"MeanOf"** was added to the beginning of each numeric variable label (i.e. all variables not "subject" or "activity") following processing and the calculation of the mean of each variable by subject and activity. This allows one to readily distinguish between the processed and unprocessed datasets.

### 3.2 List of feature types and description of labels
*Identification columns* 

Column # |Label |Description of label |Type of data
---------|---------|----------------------------------------------------|-------------------
1        |subject  |The person performing the given activities          | Integer (1-30)
2        |activity |The activity being performed by the subject        | Factor (see section 2.2.2)  

*Numeric data columns*  

Label component     |  Description of label
--------------------|------------------------------------
Time                |  The time domain from the 3-axial raw signals
Frequency           |  Denotes a Fast Fourier Transform was applied to the data
Body                |  Acceleration due to body
Gravity             |  Acceleration due to gravity
Accelerometric      |  Acceleration data from the 3-axis accelerometer
Gyroscopic          |  Acceleration data from the 3-axis gyroscope
Jerk                |  The body linear acceleration and angular velocity derived in time
Magnitude           |  Magnitude of the 3D signals calculated using the Euclidean norm
X, Y, Z             |  The axis (direction) of movement
Mean                |  The mean (average) value of the reading
StdDev              |  The standard deviation of the reading
MeanOf              |  This is the mean of the column as calculated by subject and activity

**Note:** A full list of all column labels can be found at the end of this document in **Appendix 1**

### 3.3 Variable units
During generation of the data, the data were scaled by dividing by the range, resulting in the units cancelling out. Thus the data provided are unitless and therefore no units are provided.

## 4. Output of the run_analysis.R script
The script will produce two `.txt` files containing comma separated data.

* `tidy.clean.txt`: This is the output corresponding to step 4 of the course project. It contains the columns corresponding to the mean and standard deviation for each measurement of the merged test and training datasets (see the Code Book for additional details of the included columns). It also has columns corresponding to the subject and activity, with the activity column being a factor variable, possessing descriptive activity names (again, see the Code Book for details).

* `tidy.means.txt`: This is the output corresponding to step 5 of the course project. As with the `tidy.clean.txt` output, it also contains the descriptively names columns and activities, but instead of containing the raw data, instead contains the average of each variable for each activity and each subject (180 observations for each column.  

These files can be read into R using the read.csv() command.  However, the default setting of the script will normally load both of these datasets into memory once run, so you do not have to manually read the files in.  

Note that `tidy.clean` is a large dataset of 10299 observations of 68 variables whereas `tidy.mean` is a relatively small dataset of 180 observations of 68 variables.  

If your computer does not have sufficient memory to maintain both datasets in memory, please comment out `line 113` and `line 114` in the run_analysis.R file to prevent R from loading these datasets into memory. You can then use the read.csv() function to load one or the other into R if you so desire. 

## Appendix 1
### Columns present in tidy.clean dataset
**[Column] "Column name"**  
 [1] "subject"                                        
 [2] "activity"                                       
 [3] "TimeBodyAccelerometricMeanX"                    
 [4] "TimeBodyAccelerometricMeanY"                    
 [5] "TimeBodyAccelerometricMeanZ"                    
 [6] "TimeBodyAccelerometricStdDevX"                  
 [7] "TimeBodyAccelerometricStdDevY"                  
 [8] "TimeBodyAccelerometricStdDevZ"                  
 [9] "TimeGravityAccelerometricMeanX"                 
[10] "TimeGravityAccelerometricMeanY"                 
[11] "TimeGravityAccelerometricMeanZ"                 
[12] "TimeGravityAccelerometricStdDevX"               
[13] "TimeGravityAccelerometricStdDevY"               
[14] "TimeGravityAccelerometricStdDevZ"               
[15] "TimeBodyAccelerometricJerkMeanX"                
[16] "TimeBodyAccelerometricJerkMeanY"                
[17] "TimeBodyAccelerometricJerkMeanZ"                
[18] "TimeBodyAccelerometricJerkStdDevX"              
[19] "TimeBodyAccelerometricJerkStdDevY"              
[20] "TimeBodyAccelerometricJerkStdDevZ"              
[21] "TimeBodyGyroscopicMeanX"                        
[22] "TimeBodyGyroscopicMeanY"                        
[23] "TimeBodyGyroscopicMeanZ"                        
[24] "TimeBodyGyroscopicStdDevX"                      
[25] "TimeBodyGyroscopicStdDevY"                      
[26] "TimeBodyGyroscopicStdDevZ"                      
[27] "TimeBodyGyroscopicJerkMeanX"                    
[28] "TimeBodyGyroscopicJerkMeanY"                    
[29] "TimeBodyGyroscopicJerkMeanZ"                    
[30] "TimeBodyGyroscopicJerkStdDevX"                  
[31] "TimeBodyGyroscopicJerkStdDevY"                  
[32] "TimeBodyGyroscopicJerkStdDevZ"                  
[33] "TimeBodyAccelerometricMagnittudeMean"           
[34] "TimeBodyAccelerometricMagnittudeStdDev"         
[35] "TimeGravityAccelerometricMagnittudeMean"        
[36] "TimeGravityAccelerometricMagnittudeStdDev"      
[37] "TimeBodyAccelerometricJerkMagnittudeMean"       
[38] "TimeBodyAccelerometricJerkMagnittudeStdDev"     
[39] "TimeBodyGyroscopicMagnittudeMean"               
[40] "TimeBodyGyroscopicMagnittudeStdDev"             
[41] "TimeBodyGyroscopicJerkMagnittudeMean"           
[42] "TimeBodyGyroscopicJerkMagnittudeStdDev"         
[43] "FrequencyBodyAccelerometricMeanX"               
[44] "FrequencyBodyAccelerometricMeanY"               
[45] "FrequencyBodyAccelerometricMeanZ"               
[46] "FrequencyBodyAccelerometricStdDevX"             
[47] "FrequencyBodyAccelerometricStdDevY"             
[48] "FrequencyBodyAccelerometricStdDevZ"             
[49] "FrequencyBodyAccelerometricJerkMeanX"           
[50] "FrequencyBodyAccelerometricJerkMeanY"           
[51] "FrequencyBodyAccelerometricJerkMeanZ"           
[52] "FrequencyBodyAccelerometricJerkStdDevX"         
[53] "FrequencyBodyAccelerometricJerkStdDevY"         
[54] "FrequencyBodyAccelerometricJerkStdDevZ"         
[55] "FrequencyBodyGyroscopicMeanX"                   
[56] "FrequencyBodyGyroscopicMeanY"                   
[57] "FrequencyBodyGyroscopicMeanZ"                   
[58] "FrequencyBodyGyroscopicStdDevX"                 
[59] "FrequencyBodyGyroscopicStdDevY"                 
[60] "FrequencyBodyGyroscopicStdDevZ"                 
[61] "FrequencyBodyAccelerometricMagnittudeMean"      
[62] "FrequencyBodyAccelerometricMagnittudeStdDev"    
[63] "FrequencyBodyAccelerometricJerkMagnittudeMean"  
[64] "FrequencyBodyAccelerometricJerkMagnittudeStdDev"
[65] "FrequencyBodyGyroscopicMagnittudeMean"          
[66] "FrequencyBodyGyroscopicMagnittudeStdDev"        
[67] "FrequencyBodyGyroscopicJerkMagnittudeMean"      
[68] "FrequencyBodyGyroscopicJerkMagnittudeStdDev"    

### Columns present in tidy.means dataset
**[Column] "Column name"**   
 [1] "subject"                                              
 [2] "activity"                                             
 [3] "MeanOfTimeBodyAccelerometricMeanX"                    
 [4] "MeanOfTimeBodyAccelerometricMeanY"                    
 [5] "MeanOfTimeBodyAccelerometricMeanZ"                    
 [6] "MeanOfTimeBodyAccelerometricStdDevX"                  
 [7] "MeanOfTimeBodyAccelerometricStdDevY"                  
 [8] "MeanOfTimeBodyAccelerometricStdDevZ"                  
 [9] "MeanOfTimeGravityAccelerometricMeanX"                 
[10] "MeanOfTimeGravityAccelerometricMeanY"                 
[11] "MeanOfTimeGravityAccelerometricMeanZ"                 
[12] "MeanOfTimeGravityAccelerometricStdDevX"               
[13] "MeanOfTimeGravityAccelerometricStdDevY"               
[14] "MeanOfTimeGravityAccelerometricStdDevZ"               
[15] "MeanOfTimeBodyAccelerometricJerkMeanX"                
[16] "MeanOfTimeBodyAccelerometricJerkMeanY"                
[17] "MeanOfTimeBodyAccelerometricJerkMeanZ"                
[18] "MeanOfTimeBodyAccelerometricJerkStdDevX"              
[19] "MeanOfTimeBodyAccelerometricJerkStdDevY"              
[20] "MeanOfTimeBodyAccelerometricJerkStdDevZ"              
[21] "MeanOfTimeBodyGyroscopicMeanX"                        
[22] "MeanOfTimeBodyGyroscopicMeanY"                        
[23] "MeanOfTimeBodyGyroscopicMeanZ"                        
[24] "MeanOfTimeBodyGyroscopicStdDevX"                      
[25] "MeanOfTimeBodyGyroscopicStdDevY"                      
[26] "MeanOfTimeBodyGyroscopicStdDevZ"                      
[27] "MeanOfTimeBodyGyroscopicJerkMeanX"                    
[28] "MeanOfTimeBodyGyroscopicJerkMeanY"                    
[29] "MeanOfTimeBodyGyroscopicJerkMeanZ"                    
[30] "MeanOfTimeBodyGyroscopicJerkStdDevX"                  
[31] "MeanOfTimeBodyGyroscopicJerkStdDevY"                  
[32] "MeanOfTimeBodyGyroscopicJerkStdDevZ"                  
[33] "MeanOfTimeBodyAccelerometricMagnittudeMean"           
[34] "MeanOfTimeBodyAccelerometricMagnittudeStdDev"         
[35] "MeanOfTimeGravityAccelerometricMagnittudeMean"        
[36] "MeanOfTimeGravityAccelerometricMagnittudeStdDev"      
[37] "MeanOfTimeBodyAccelerometricJerkMagnittudeMean"       
[38] "MeanOfTimeBodyAccelerometricJerkMagnittudeStdDev"     
[39] "MeanOfTimeBodyGyroscopicMagnittudeMean"               
[40] "MeanOfTimeBodyGyroscopicMagnittudeStdDev"             
[41] "MeanOfTimeBodyGyroscopicJerkMagnittudeMean"           
[42] "MeanOfTimeBodyGyroscopicJerkMagnittudeStdDev"         
[43] "MeanOfFrequencyBodyAccelerometricMeanX"               
[44] "MeanOfFrequencyBodyAccelerometricMeanY"               
[45] "MeanOfFrequencyBodyAccelerometricMeanZ"               
[46] "MeanOfFrequencyBodyAccelerometricStdDevX"             
[47] "MeanOfFrequencyBodyAccelerometricStdDevY"             
[48] "MeanOfFrequencyBodyAccelerometricStdDevZ"             
[49] "MeanOfFrequencyBodyAccelerometricJerkMeanX"           
[50] "MeanOfFrequencyBodyAccelerometricJerkMeanY"           
[51] "MeanOfFrequencyBodyAccelerometricJerkMeanZ"           
[52] "MeanOfFrequencyBodyAccelerometricJerkStdDevX"         
[53] "MeanOfFrequencyBodyAccelerometricJerkStdDevY"         
[54] "MeanOfFrequencyBodyAccelerometricJerkStdDevZ"         
[55] "MeanOfFrequencyBodyGyroscopicMeanX"                   
[56] "MeanOfFrequencyBodyGyroscopicMeanY"                   
[57] "MeanOfFrequencyBodyGyroscopicMeanZ"                   
[58] "MeanOfFrequencyBodyGyroscopicStdDevX"                 
[59] "MeanOfFrequencyBodyGyroscopicStdDevY"                 
[60] "MeanOfFrequencyBodyGyroscopicStdDevZ"                 
[61] "MeanOfFrequencyBodyAccelerometricMagnittudeMean"      
[62] "MeanOfFrequencyBodyAccelerometricMagnittudeStdDev"    
[63] "MeanOfFrequencyBodyAccelerometricJerkMagnittudeMean"  
[64] "MeanOfFrequencyBodyAccelerometricJerkMagnittudeStdDev"
[65] "MeanOfFrequencyBodyGyroscopicMagnittudeMean"          
[66] "MeanOfFrequencyBodyGyroscopicMagnittudeStdDev"        
[67] "MeanOfFrequencyBodyGyroscopicJerkMagnittudeMean"      
[68] "MeanOfFrequencyBodyGyroscopicJerkMagnittudeStdDev" 
