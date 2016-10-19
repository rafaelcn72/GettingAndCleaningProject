## Getting and Cleaning Data Course Project ##
## Rafael Cabrera Namora ##

library(dplyr)

# Set work directory and create Getting and Cleaning Project directory
setwd("F:/15 - R")
if(!file.exists("./get")) dir.create("./get")

# Download zip file from website and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./get/get_project.zip")
listZip <- unzip("./get/get_project.zip", exdir = "./get")


# Read data to R
x_train <- read.table("./get/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./get/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./get/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./get/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./get/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./get/UCI HAR Dataset/test/subject_test.txt")

features <- read.table('./get/UCI HAR Dataset/features.txt')

activityLabels = read.table('./get/UCI HAR Dataset/activity_labels.txt')


colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

### Merges the training and the test sets to create one data set.
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
alldata <- rbind(merge_train, merge_test)

### Extracts only the measurements on the mean and standard deviation for each measurement.
### Appropriately labels the data set with descriptive variable names.
col_names <- colnames(alldata)

stats <- (grepl("activityId" , col_names) | 
                   grepl("subjectId" , col_names) | 
                   grepl("mean.." , col_names) | 
                   grepl("std.." , col_names) 
)

proj_data <- alldata[ , stats == TRUE]

### Uses descriptive activity names to name the activities in the data set.
activity_names <- merge(proj_data, activityLabels,
                              by='activityId',
                              all.x=TRUE)

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- aggregate(. ~subjectId + activityId, activity_names, mean)
tidy_data <- tidy_data[order(tidy_data$subjectId, tidy_data$activityId),]

write.table(tidy_data, "./get/get_proj_mean_v2.txt", row.name=FALSE)

