# Getting and Cleaning Data - Coursera
# Course Project
# by Edneide Ramalho
# June, 2021

# Libraries----
library(tidyverse)

# 1. Merges the training and the test sets to create one data set.--------

## Importing the data sets ---------------------------

##---------------------------------------------------##  
### Training set and training labels ------------------
##---------------------------------------------------##  
train_set <- read.table("UCI HAR Dataset/train/X_train.txt")

train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")

# Binding in one data frame
train_df <- cbind(train_labels, train_set)
names(train_df)[1] <- "labels"

##---------------------------------------------------##  
### Test set and test labels -------------------------
##---------------------------------------------------##  
test_set <- read.table("UCI HAR Dataset/test/X_test.txt")

test_labels <- read.table("UCI HAR Dataset/test/Y_test.txt")

# Binding in one data frame
test_df <- cbind(test_labels, test_set)
names(test_df)[1] <- "labels"

# Features data set
features <- read.table("UCI HAR Dataset/features.txt")

# Naming the features in the train and test data sets
names(train_df)[-1] <- features$V2
names(test_df)[-1] <- features$V2


##-------------------##
## Subject data sets 
##-------------------##
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subject"
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "subject"

## Merging data sets: train and test -------------------------
df_total <- rbind(cbind(subject_train, train_df), 
                  cbind(subject_test, test_df))


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.---- 

df_mean_std <- df_total %>% 
  select(subject, labels, contains(c("mean", "std")))

# 3. Uses descriptive activity names to name the activities in the data set----

# Importing activity_labels.txt
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Adding the activity name
df_mean_std <- df_mean_std %>% 
  left_join(activity_labels, by = c("labels" = "V1"))

# Excluding the labels in number format
df_mean_std <- df_mean_std %>% 
  select(subject, activity = V2, `tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`)

# 4. Appropriately labels the data set with descriptive variable names.---- 
names(df_mean_std) <- gsub("Acc", "_accelerometer", names(df_mean_std)) 
names(df_mean_std) <- gsub("-std()", "_std", names(df_mean_std)) 
names(df_mean_std) <- gsub("-mean()", "_mean", names(df_mean_std)) 
names(df_mean_std) <- gsub("-X", "_xaxis", names(df_mean_std)) 
names(df_mean_std) <- gsub("-Y", "_yaxis", names(df_mean_std)) 
names(df_mean_std) <- gsub("-Z", "_zaxis", names(df_mean_std)) 
names(df_mean_std) <- gsub("^t", "time_", names(df_mean_std))
names(df_mean_std) <- gsub("Gyro", "_gyroscope", names(df_mean_std)) 
names(df_mean_std) <- gsub("^f", "frequency_", names(df_mean_std))
names(df_mean_std)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.----

df_final <- df_mean_std %>% 
  group_by(activity, subject) %>% 
  summarise_all(list(mean = mean))

# Taking a look at the final table structure:
glimpse(df_final)

# Savind the final table in csv:
write.table(df_final, "df_final.txt", row.names = FALSE)
