==== Getting and Cleaning Data Course - Programming Assignment ====

The goal of this assignment is to prepare tidy data that can be used for later analysis.
The raw data are available here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and a full description is available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

First download and unzip the data, you will have a folder named "UCI HAR Dataset". Put the run_analysis.R script where the "UCI HAR Dataset" folder is. This will be your working directory, remember to set the right path in RStudio before doing
> source(~/run_analysis.R)

This will start the analysis, it will take a few moments. In the end you will have in your workspace two R objects and two new files. The first R object is called goodData and it is a data.frame with the merged data sets for "train" and "test" measurements (10299 observations with 81 columns). The second R object is averageData (a data.frame) with 180 observations with 81 columns and it is an independent tidy data set with the average of each variable for each activity and each subject.

goodData is also printed in "allData.txt" and
averageData is also printed in "averageData.txt"
in the same working directory.


