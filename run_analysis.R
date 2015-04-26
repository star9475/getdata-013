##
##  Coursera - Getting and Cleaning Data - getdata-013 - Course Project
##  josh starkey - star9475@hotmail.com
##  https://class.coursera.org/getdata-013/human_grading/view/courses/973500/assessments/3/submissions## 
##
#
# One of the most exciting areas in all of data science right now is wearable computing - 
# see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to 
# develop the most advanced algorithms to attract new users. 
# The data linked to from the course website represent data collected from the accelerometers 
# from the Samsung Galaxy S smartphone. A full description is available at the site where the 
# data was obtained: 
#
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#      
#      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
run_analysis <- function(directory) {

     library(plyr)
     
     ## First thing we need to do is load the data sets
     ## Assuming the working directory is this file's location
     data_dir <- "dataset/UCI HAR Dataset/"
     
     ## load the training data set
     ## note the 1st operation takes 20 seconds, maybe there's a way to speed it up
     x_train_data <- read.table("dataset/UCI HAR Dataset/train/X_train.txt")
     y_train_data <- read.table("dataset/UCI HAR Dataset/train/Y_train.txt")
     subject_train_data <- read.table("dataset/UCI HAR Dataset/train/subject_train.txt")
               
     ## load the test data set
     ## note the 1st operation takes 20 seconds, maybe there's a way to speed it up
     x_test_data <- read.table("dataset/UCI HAR Dataset/test/X_test.txt")
     y_test_data <- read.table("dataset/UCI HAR Dataset/test/Y_test.txt")
     subject_test_data <- read.table("dataset/UCI HAR Dataset/test/subject_test.txt")
          
     ## load activity labels
     activity_labels <- read.table("dataset/UCI HAR Dataset/activity_labels.txt")

     ## read in the features (labels for each of the variables)
     features <- read.table("dataset/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

     ##  add the features as column names
     colnames(x_train_data) <- features[,2]
     colnames(subject_train_data) <- c("SubjectID")
     colnames(y_train_data) <- c("ActivityID")
     
     colnames(x_test_data) <- features[,2]
     colnames(subject_test_data) <- c("SubjectID")
     colnames(y_test_data) <- c("ActivityID")
     
     
     #      1. Merges the training and the test sets to create one data set.
     ## Merge the training data set
     test <- cbind(x_train_data,y_train_data)
     train_data <- cbind(test, subject_train_data)
     
     test <- cbind(x_test_data,y_test_data)
     test_data <- cbind(test, subject_test_data)
     
     combined_data <- rbind(train_data, test_data)
     
     #      2 .Extracts only the measurements on the mean and standard deviation for each measurement. 
     data_extract <- combined_data[c("SubjectID", "ActivityID", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z")]
     #x_data_extract <- x_data[c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z")]
     
     #      3. Uses descriptive activity names to name the activities in the data set
     temp_df <- data.frame(as.factor(activity_labels$V2))
     colnames(temp_df) <- c("Activity")
     vec <- as.numeric(data_extract$ActivityID)
     
     data_extract <- cbind(data_extract, temp_df$Activity[vec])
     colnames(data_extract)[9] <- "Activity"
     
     #      4. Appropriately labels the data set with descriptive variable names. 

     colnames(data_extract)[3] <- "Mean_X"
     colnames(data_extract)[4] <- "Mean_Y"
     colnames(data_extract)[5] <- "Mean_Z"
     colnames(data_extract)[6] <- "StdDev_X"
     colnames(data_extract)[7] <- "StdDev_Y"
     colnames(data_extract)[8] <- "StdDev_Z"
     colnames(data_extract)[9] <- "Activity"
     
     #    From the data set in step 4, creates a second, independent tidy data set 
     #    with the average of each variable for each activity and each subject.        
     #           
     tidy_extract <- ddply(data_extract, c("SubjectID", "Activity"), summarize, mean.X = mean(Mean_X), mean.Y = mean(Mean_Y), mean.Z = mean(Mean_Z), sd.x = sd(StdDev_X), sd.y = sd(StdDev_Y), sd.z = sd(StdDev_Z) )
     
     
     ## Write the tidy data set to a text file
     write.table(tidy_extract, file="tidy_extract.txt", sep=",", row.name=FALSE)
     
     
}

