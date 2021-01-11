# Getting-and-Cleaning-Data-Course-Project

This is a course project for the Coursera Course "Getting and Cleaning Data"

## This repository contains the following files:

- README.md
- run_analysis.R
- CodeBook.md
- TidyData.txt

## The README.md file
Gives overview of the files and information oof the project

Project Information: 
  - A full description of the project is available at the site where the data was obtained:
      http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  - Used data for the project:
      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
      (Full information on the Project and tha varibales included)

## The run_analysis.R file
The analysis contains the following steps
  1. Merges the training and the test sets to create one data set.
   2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The CodeBook.md file
Names and describes the variables, data and data transformations used in this project

## The TidyData.txt file
Contains a independent tidy data set with the average of each variable for each activity and each subject
The script of how the data set was created can be found in "run_analysis.R" Step 5