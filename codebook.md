---
title: "Coursera - Getting and Cleaning Data - getdata-013 - Course Project"
author: "Josh Starkey - star9475@hotmail.com"
date: "Sunday, April 26, 2015"
output: html_document
---

The class assignment is found here:  
https://class.coursera.org/getdata-013/human_grading/view/courses/973500/assessments/3/submissions#

A full description is available at the site where the data was obtained: 

     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
 
Here are the data for the project: 
      
     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 
To perform the analysis, a script called run_analysis.R was created. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Variables:

     x_train_data - reads the X_train.txt data
     y_train_data - reads the Y_train.txt data
     subject_train_data - reads the subject train data
               
     x_test_data - reads the X_test.txt
     y_test_data - reads the Y_test.txt
     subject_test_data - reads the subject_test.txt

     activity_labels - reads the activity_labels.txt

     features - reads the features lables

     train_data - contains the training data merged
     test_data - contains the test data merged
     
     combined_data - the merged test and training data
     
     data_extract - contains the extracted columns from the merged data
     tidy_extract - contains the summarized tidy data to output

The analysis creates a tidy data set and outputs it to the file tidy_extract


