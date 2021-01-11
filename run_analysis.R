# laoding required packages and libraries

# downloading data (full description of the data on http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "~/Documents/Coursera/Getting and Cleaning Data/zipfile.zip", method = "curl")
unzip("../zipfile.zip")


# 1. Merge the training and the test sets

   # Step1: Read data and create trainig table
    trainData <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
    trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
    trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
    
    trainTable <- cbind.data.frame(trainSubject, trainActivity, trainData)
    
   # Step2: Read data and create test table 
    testData <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
    testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
    testActivity <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
    
    testTable <- cbind.data.frame(testSubject, testActivity, testData)
    
   # Step3: Merging train and test table 
    
    fullTable <- rbind.data.frame(trainTable, testTable)
  
# 2. Extract only the measurements on the mean and standard diviation 
    
   # Step1: Adding column names 
    colnames(fullTable)[1] <- "Subject"
    colnames(fullTable)[2] <- "Activity_ID"
    features <- read.table("UCI HAR Dataset/features.txt", header = FALSE) #the variable names for the data are extracted from the features.txt file 
    colnames(fullTable)[3:563] <- features[,2]
    
   # Step2: Extract measurements based on the column names 
    MeanandStdVektor <- grep("(mean|std)", names(fullTable)) 
    MeanAndStdTable <-  fullTable[, c(1,2, MeanandStdVektor)] 
    
    
# 3. Use descriptive names to name the activities
    
    #Step1: Read the activity lables from the given document
    activityNames <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
    activityNames
    
    #Step2: Add a new variable to the MeanAndStdTable which is called Activity_Labels, assign the corresponding with the help of the variable activityNames
     MeanAndStdTable$Activity_Lable <- ifelse(MeanAndStdTable$Activity_ID == 1, "Walking", 
                                       ifelse (MeanAndStdTable$Activity_ID == 2, "Walking_Upstairs", 
                                             ifelse(MeanAndStdTable$Activity_ID == 3, "Walking_Downstairs",
                                             ifelse(MeanAndStdTable$Activity_ID == 4, "Sitting",
                                              ifelse(MeanAndStdTable$Activity_ID == 5, "Standing",
                                                     ifelse(MeanAndStdTable$Activity_ID == 6, "Laying", NA))))))
   
# 4. Appropriately labels the data set with descriptive variable names
     #Step1: Duplicate the data set, so the old set with old names remain available
     MeanAndStdTableNewNames <- MeanAndStdTable
     
     #Step2: Rename the variable names 
     names(MeanAndStdTableNewNames) <- gsub("^t", "Time", names(MeanAndStdTableNewNames))
     names(MeanAndStdTableNewNames) <- gsub("^f", "Freuquency", names(MeanAndStdTableNewNames))
     names(MeanAndStdTableNewNames) <- gsub("mean", "MeanValue", names(MeanAndStdTableNewNames))
     names(MeanAndStdTableNewNames) <- gsub("std", "StandardDeviation", names(MeanAndStdTableNewNames))
     names(MeanAndStdTableNewNames) <- gsub("[()]", "", names(MeanAndStdTableNewNames))
     names(MeanAndStdTableNewNames) <- gsub("Gyro", "Gyroscope", names(MeanAndStdTableNewNames))
     names(MeanAndStdTableNewNames) <- gsub("Acc", "Accelerometer", names(MeanAndStdTableNewNames))
     names(MeanAndStdTableNewNames) <- gsub("Mag", "Magnitude", names(MeanAndStdTableNewNames))
     names(MeanAndStdTableNewNames)
  
   
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   # library(dplyr)
    #groups <-  MeanAndStdTable %>% group_by(Subject, Activity_ID)
    #groups
     MeanByGroups <- aggregate(MeanAndStdTableNewNames[3:81], FUN=mean, 
                      by=list(Subject = MeanAndStdTableNewNames$Subject, Activity_Lable = MeanAndStdTableNewNames$Activity_Lable))
                
     write.table(MeanByGroups, "~/Documents/Coursera/Getting and Cleaning Data/Getting-and-Cleaning-Data-Course-Project/TidyData.txt", row.name=FALSE) 
  