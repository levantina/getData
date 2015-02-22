#Programming Assignment for the Coursera Course "Getting And Cleaning Data"
#This file reads raw data sets from the "UCI HAR Dataset" folder and creates a tidy 
#data set with appropriate labels and descriptive variable names. 

#This first part reads the test and train data sets and then merges it 
#in only one data.table.

#Reads the "training" (train) data set with subjects and labels
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")

#Reads the "test" data set with subjects and labels
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt") 

#Merges the data sets
allSubjects <- rbind(trainSubject, testSubject)
allData <- rbind(trainData, testData)
allLabels <- rbind(trainLabel, testLabel)

#Extracts only the values on the mean and standard 
# deviation for each measurement.

features <- read.table("./UCI HAR Dataset/features.txt")
selection <- grep("mean()|std()", features[, 2])
allData <- allData[, selection]
#Changes column names removing "()"
names(allData) <- gsub("\\(\\)", "", features[selection, 2])
#Replaces mean with Mean
names(allData) <- gsub("mean", "Mean", names(allData))
#Replaces std with Std
names(allData) <- gsub("std", "Std", names(allData))
#Changes column names removing "-"
names(allData) <- gsub("-", "", names(allData))

#Uses descriptive activity names (in activity_labels.txt) 
#to assign names to the activities in data sets.

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabels <- activity[allLabels[, 1], 2]
allLabels[, 1] <- activityLabels
names(allLabels) <- "activity"

#Assigns labels to the data set with previous activity names 
#and writes the merged dataset (goodData) in the file allData.txt. 

names(allSubjects) <- "subject"
#merges the data
goodData <- cbind(allSubjects, allLabels, allData)
#sets to factors the integers representing subjects and activities
goodData$subject <- as.factor(goodData$subject)
goodData$activity <- as.factor(goodData$activity)
#write on file the merged data set
write.table(goodData, "allData.txt")

#Creates a cleaned data set with the average of each variable 
#for each subject and each kind of activity. 

#First creates a matrix of dimensions N*M 
#and then converts it into a data.frame.
S <- length(table(allSubjects))
L <- dim(activity)[1]
N <- S*L
M <- dim(goodData)[2]

averageData <- matrix(NA, nrow=N, ncol=M) 
averageData <- as.data.frame(averageData)
colnames(averageData) <- colnames(goodData)

#Then fills the data.frame with averages values.
n <- 1
for(i in 1:S) {
      for(j in 1:L) {
            averageData[n, 1] <- sort(unique(allSubjects)[, 1])[i]
            averageData[n, 2] <- activity[j, 2]
            firstSelection <- i == goodData$subject
            secondSelection <- activity[j, 2] == goodData$activity
            averageData[n, 3:M] <- colMeans(goodData[firstSelection&secondSelection, 3:M])
            n <- n + 1
      }
}
#sets to factors the integers representing subjects and activities
averageData$subject <- as.factor(averageData$subject)
averageData$activity <- as.factor(averageData$activity)
#Writes the data.frame on file
write.table(averageData, "averageData.txt") 

#In the end it cleans the workspace, except goodData and averageData
#(the two requested tidy data frames)
rm(trainSubject, trainData, trainLabel, testSubject, testData, testLabel, allSubjects, 
   allLabels, features, activity, activityLabels, allData, selection, S, L, 
   N, M, i, j, n, firstSelection, secondSelection)
