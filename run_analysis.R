### Coursera Data Science Specialization
### Course:  Getting and Cleaning Data
### Project: Create Tidy Dataset from UCI Machine Learning Smartphone Data 

## Before running this script, unzip "UCI HAR Dataset.zip" into location: [Working Directory]/UCI HAR Dataset
## (zip file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Load packages ----
library(plyr)

### Step 1: Get Data ----

## Set working directory to subdirectory of unzipped UCI HAR Dataset folder
setwd("UCI HAR Dataset")

## Get data and properly label column names
  #features: column names for datasets
	features <- read.table("features.txt")
  
  #X_test, X_train: smartphone accelerometer & gyroscope data
	X_test <- read.table("test/X_test.txt")
	colnames(X_test) <- as.character(features$V2)

	X_train <- read.table("train/X_train.txt")
	colnames(X_train) <- as.character(features$V2)

  #y_test , y_train: activity ID's, which correspond to entries in activity_labels
	y_test <- read.table("test/y_test.txt")
	colnames(y_test) <- "activity_id"

	y_train <- read.table("train/y_train.txt")
	colnames(y_train) <- "activity_id"

	subject_test <- read.table("test/subject_test.txt")
	colnames(subject_test) <- "subject"

  #activity_labels: activity ID & activity description
    activity_labels <- read.table("activity_labels.txt")
    colnames(activity_labels) <- c("activity_id","activity")
  
  #subject_train: subject ID's, identifying who wore the smartphone
	subject_train <- read.table("train/subject_train.txt")
	colnames(subject_train) <- "subject"

## Set working directory back to original
setwd("..")

### Step 2: Merge Training & Test Datasets ----
#create new column in each dataset, "test" or "train", for reference of data source
X_test$dataset <- rep("test",times=2947)
X_train$dataset <- rep("train",times=7352)
y_test$dataset <- rep("test",times=2947)
y_train$dataset <- rep("train",times=7352)
subject_test$dataset <- rep("test",times=2947)
subject_train$dataset <- rep("train",times=7352)

#combine test and train datasets via rbind
merged_X <- rbind(X_test,X_train)
merged_y <- rbind(y_test,y_train)
merged_subject <- rbind(subject_test,subject_train)

#combine all three merged datasets into one data frame
df <- cbind(merged_X,activity_id=merged_y[,1],subject=merged_subject[,1])

### Step 3: Extract mean and standard deviation ----
df_mean_std <- df[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,
                     125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,
                     253,254,266,267,268,269,270,271,294,295,296,345,346,347,348,349,
                     350,373,374,375,424,425,426,427,428,429,452,453,454,503,504,513,
                     516,517,526,529,530,539,542,543,552,562,563,564)]

### Step 4: Label with Descriptive Activity names ----

# Label activities in "df_mean_std" with corresponding description in "activity_labels"
df_mean_std2 <- merge(df_mean_std, activity_labels, by.x="activity_id", by.y="activity_id", sort=FALSE)

### Step 5: Summarize ----
  # Go through each variable in df_mean_std2 and get the mean,
  # grouped by subject & activity_id only doing this for numeric
  # columns, which leaves out variables "dataset" and "activity"
  df_mean_std2_mean <- ddply(df_mean_std2, c("subject","activity_id"),colwise(mean,is.numeric))

  # Name columns neatly, and assign to names of df_mean_std2_mean
  neat_column_names <- c("subject", "activity_id", "time.body.accelerometer.3axialX.mean", 
                         "time.body.accelerometer.3axialY.mean", "time.body.accelerometer.3axialZ.mean", 
                         "time.body.accelerometer.3axialX.std", "time.body.accelerometer.3axialY.std", 
                         "time.body.accelerometer.3axialZ.std", "time.gravity.accelerometer.3axialX.mean", 
                         "time.gravity.accelerometer.3axialY.mean", "time.gravity.accelerometer.3axialZ.mean", 
                         "time.gravity.accelerometer.3axialX.std", "time.gravity.accelerometer.3axialY.std", 
                         "time.gravity.accelerometer.3axialZ.std", "time.body.accelerometer.jerk3axialX.mean", 
                         "time.body.accelerometer.jerk3axialY.mean", "time.body.accelerometer.jerk3axialZ.mean", 
                         "time.body.accelerometer.jerk3axialX.std", "time.body.accelerometer.jerk3axialY.std", 
                         "time.body.accelerometer.jerk3axialZ.std", "time.body.gyroscope.3axialX.mean", 
                         "time.body.gyroscope.3axialY.mean", "time.body.gyroscope.3axialZ.mean", 
                         "time.body.gyroscope.3axialX.std", "time.body.gyroscope.3axialY.std", 
                         "time.body.gyroscope.3axialZ.std", "time.body.gyroscope.jerk3axialX.mean", 
                         "time.body.gyroscope.jerk3axialY.mean", "time.body.gyroscope.jerk3axialZ.mean", 
                         "time.body.gyroscope.jerk3axialX.std", "time.body.gyroscope.jerk3axialY.std", 
                         "time.body.gyroscope.jerk3axialZ.std", "time.body.accelerometer.magnitude.mean", 
                         "time.body.accelerometer.magnitude.std", "time.gravity.accelerometer.magnitude.mean", 
                         "time.gravity.accelerometer.magnitude.std", "time.body.accelerometer.jerkmagnitude.mean", 
                         "time.body.accelerometer.jerkmagnitude.std", "time.body.gyroscope.magnitude.mean", 
                         "time.body.gyroscope.magnitude.std", "time.body.gyroscope.jerkmagnitude.mean", 
                         "time.body.gyroscope.jerkmagnitude.std", "frequency.body.accelerometer.3axialX.mean", 
                         "frequency.body.accelerometer.3axialY.mean", "frequency.body.accelerometer.3axialZ.mean", 
                         "frequency.body.accelerometer.3axialX.std", "frequency.body.accelerometer.3axialY.std", 
                         "frequency.body.accelerometer.3axialZ.std", "frequency.body.accelerometer.3axialX.meanFreq", 
                         "frequency.body.accelerometer.3axialY.meanFreq", "frequency.body.accelerometer.3axialZ.meanFreq", 
                         "frequency.body.accelerometer.jerk3axialX.mean", "frequency.body.accelerometer.jerk3axialY.mean", 
                         "frequency.body.accelerometer.jerk3axialZ.mean", "frequency.body.accelerometer.jerk3axialX.std", 
                         "frequency.body.accelerometer.jerk3axialY.std", "frequency.body.accelerometer.jerk3axialZ.std", 
                         "frequency.body.accelerometer.jerk3axialX.meanFreq", "frequency.body.accelerometer.jerk3axialY.meanFreq", 
                         "frequency.body.accelerometer.jerk3axialZ.meanFreq", "frequency.body.gyroscope.3axialX.mean", 
                         "frequency.body.gyroscope.3axialY.mean", "frequency.body.gyroscope.3axialZ.mean", 
                         "frequency.body.gyroscope.3axialX.std", "frequency.body.gyroscope.3axialY.std", 
                         "frequency.body.gyroscope.3axialZ.std", "frequency.body.gyroscope.3axialX.meanFreq", 
                         "frequency.body.gyroscope.3axialY.meanFreq", "frequency.body.gyroscope.3axialZ.meanFreq", 
                         "frequency.body.accelerometer.magnitude.mean", "frequency.body.accelerometer.magnitude.std", 
                         "frequency.body.accelerometer.magnitude.meanFreq", "frequency.body.accelerometer.jerkmagnitude.mean", 
                         "frequency.body.accelerometer.jerkmagnitude.std", "frequency.body.accelerometer.jerkmagnitude.meanFreq", 
                         "frequency.body.gyroscope.magnitude.mean", "frequency.body.gyroscope.magnitude.std", 
                         "frequency.body.gyroscope.magnitude.meanFreq", "frequency.body.gyroscope.jerkmagnitude.mean", 
                         "frequency.body.gyroscope.jerkmagnitude.std", "frequency.body.gyroscope.jerkmagnitude.meanFreq")
  names(df_mean_std2_mean) <- neat_column_names
  
### Final Processing ----
  ## Dataset #1: with descriptive variable names

    # Re-order columns in df_mean_std2 for easier viewing (categorical first, numeric afterwards)
    df_mean_std2_ordered <- data.frame(activity_id = df_mean_std2[,1], activity = df_mean_std2[,83], 
                    subject = df_mean_std2[,82], dataset = df_mean_std2[,81],df_mean_std2[,2:80])  

    # Write re-ordered data frame to csv file in working directory
    write.table(df_mean_std2_ordered, "UCI_HAR_data_withdescriptions.txt", row.names=FALSE)
    
  ## Dataset #2: tidy data set with the average of each variable for each activity and each subject.
    
    # Write df_mean_std2_mean to csv file in working directory
    write.table(df_mean_std2_mean, "UCI_HAR_data_tidyaverages.txt", row.names=FALSE)
  
  ## Clean-up: Clear all objects created in this script out of the R Global Environment  
    rm(list=c("activity_labels", "df", "df_mean_std", "df_mean_std2", "df_mean_std2_mean",
    "df_mean_std2_ordered", "features", "merged_subject", "merged_X", "merged_y",
    "subject_test", "subject_train", "X_test", "X_train", "y_test", "y_train", "neat_column_names"))
  