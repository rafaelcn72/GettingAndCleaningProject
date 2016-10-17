#Getting and Cleaning Data Project
Getting and Cleaning Data Course - Project

This file is about the variables and summaries calculated in the project.

## About Source Data

As source data for the experiment conducted was used Human Activity Recognition Using Smartphones Data Set.

A full description of the original data collected is available at the site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The downloaded data for the project was obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Introduction for the analysis on the original data

- "X_train.txt", "y_train.txt" and "subject_train.txt" contain information about training data.
- "X_test.txt", "y_test.txt" and "subjuect_test.txt" contain information about testing data.
- "features.txt" contains names of all measurements.

## Introduction for the R code "run_analysis.R" submmited

- Using `download.file()` together with `unzip()` function to download the zip file from website to my compute. 
- Using `read.table()` function to load "X_train.txt", "y_train", "subject_train" in train directory and "X_test", "y_test", "subject_test" into R.
- Using `rbind()` and `cbind()` functions to merge all train and test data together.

- Using `read.table()` function to load "features.txt" into R.
- Using `grep()` function to find the indexes with "mean()" and "sd()".
- select all relevant columns and set the columns name using the selected features name.

- Using `read.table()` function to load "activity_labels.txt" into R.
- Using `factor()` function with arguments "levels = " and "labels = " to replace the numbers to activity names.

- Using `gsub()` function to replace all characters I think they are needed to replace.

- Using `group_by()` and `summarise_each()` functions in `dplyr` package to calculate all means for each activity and wach subject.

## About variables data

- x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
- x_data, y_data and subject_data merge the previous datasets to further analysis.
- features contains the correct names for the x_data dataset, which are applied to the column names stored in.
