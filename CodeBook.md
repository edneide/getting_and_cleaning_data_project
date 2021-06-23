# Getting and Cleaning Data Course Project

We are going to use the tidyverse library.

`install.packages("tidyverse")`

`library(tidyverse)`

Five steps were followed, in each one some operations were performed and are described below.

**1. Merges the training and the test sets to create one data set.**

First, the train dataset and train labels dataset set were imported and put together using cbind. The same was done with the test data set. The first column was renamed to `labels`. Two data frames were created: `train_df` and `test_df`.

Secondly, the `subject_test` and `subject_train` sets were imported. Using `cbind` the test an train data sets were merged with the correspondent subject data sets. 

Finally, a final table is created, called `df_total` with train and test data sets merged. This table has 10299 rows and 563 columns.

**2. Extracts only the measurements on the mean and standard deviation for each measurement.** 

In order to perform this step, we selected variables from `df_total` containing  the words "mean" and "std", using the argument `contains(c("mean", "std")` inside the `select` verb. The new data frame was called `df_mean_std` and has dimensions (10299 rows and 88 columns). 


**3. Uses descriptive activity names to name the activities in the data set**

In order to use descriptive activity names we imported the  `activity_labels` data set and used `lef_join` to add the activity names instead of numbers. The data set `df_mean_std` was updated containing the `subject`, `activity`, and the variables with mean and standard deviation previously selected.  


**4. Appropriately labels the data set with descriptive variable names.** 

Some modifications were made in the variables names to let them more descriptive. The alterations are described below:

- `Acc` was replaced by   `_accelerometer"`
- `-std()` was replaced by `_std`
- `-mean()` was replaced by `_mean`
- `-X` was replaced by `_xaxis`
- `-Y` was replaced by `_yaxis`
- `-Z` was replaced by `_zaxis`
- `t` was replaced by `time_` 
- `Gyro` was replaced by `_gyroscope`
- `f` was replaced by `frequency_`


**5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

The final step was to group the variables by activity and subject using the `group_by` verb and summarise all variables calculating the mean.

The final table called `df_final` was exported in `.txt` and contains 180 observations of 88 variables.

