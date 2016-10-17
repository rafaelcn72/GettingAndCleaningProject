## Getting and Cleaning Data Course Project ##

library(dplyr)

# Set work directory and create Getting and Cleaning Project directory
setwd("C:/Users/Rafael/Documents/MEGA/R")
if(!file.exists("./get")) dir.create("./get")

# Download zip file from website and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./get/get_project.zip")
listZip <- unzip("./get/get_project.zip", exdir = "./get")

# Read data to R
X_train <- read.table("./get/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./get/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./get/UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("./get/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./get/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./get/UCI HAR Dataset/test/subject_test.txt")


### 1. Merges the training and the test sets to create one data set.
train_merge <- cbind(X_train, y_train, subject_train)
test_merge <- cbind(X_test, y_test, subject_test)
all_data <- rbind(train_merge, test_merge)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
name_feature <- read.table("./get/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]
i_feature <- grep(("mean\\(\\)|std\\(\\)"), name_feature)
proj_data <- all_data[, c(1, 2, i_feature+2)]
colnames(proj_data) <- c("subject", "activity", name_feature[i_feature])


### 3. Uses descriptive activity names to name the activities in the data set.
activity_labels <- read.table("./get/UCI HAR Dataset/activity_labels.txt")
proj_data$activity <- factor(proj_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])


### 4. Appropriately labels the data set with descriptive variable names.
names(proj_data) <- gsub("\\()", "", names(proj_data))
names(proj_data) <- gsub("^t", "time", names(proj_data))
names(proj_data) <- gsub("^f", "frequence", names(proj_data))
names(proj_data) <- gsub("-mean", "mean", names(proj_data))
names(proj_data) <- gsub("-std", "std", names(proj_data))


### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
get_proj_mean <- proj_data %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

write.table(get_proj_mean, "./get/get_proj_mean.txt", row.names = FALSE)
