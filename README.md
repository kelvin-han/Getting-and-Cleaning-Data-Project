## Getting-and-Cleaning-Data-Project

#Overview
This project serves to demonstrate the collection, review and cleaning of a tidy data set to be used for later analysis. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


#Input
Once the data is downloaded, the training and test folders should be placed in the working directory.

./train/subject_train.txt
./train/Y_train.txt
./train/X_train.txt

./testing/subject_test.txt
./test/Y_test.txt
./test/X_test.txt


#Running the R script
The following package(s) are required
. reshape2

run_analysis.R does the following
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#Output
A data.txt file will be generated in the working directory.
