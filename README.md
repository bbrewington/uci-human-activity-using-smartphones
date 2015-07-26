# uci-human-activity-using-smartphones
Course Project for Coursera Data Science Specialization, "Getting and Cleaning Data" - converting UCI's "Human Activity Using Smartphones" dataset to tidy data format

1. Download data from this zip file into working directory
   * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. In this github repository, download script **run_analysis.R** to your working directory
   * Link to repo: https://github.com/bbrewington/uci-human-activity-using-smartphones
3. Run the code in R via the "source" command (you can copy+paste the code shown below
        source("run_analysis.R")
4. The code will do perform the following tasks:
   * Properly label column names for subject, activity_id, X_test, X_train, y_test, y_train
   * Concatenate training & test datasets (for X, y, and subject), and tag records as "test" or "train" for reference
   * Extract only variables referring to mean or standard deviation (refer to description shown in code book)
   * Label data with descriptive activity names <-- this is done as an exercise, and not inlcuded in the final neat dataset
   * Calculate mean, grouped by subject & activity_id, and save this to a new data frame
   * Name the fields in this data frame in a "neat" manner so that it is easy for the user to understand, and R can work with the names
   * Create 2 datasets:
      * "UCI_HAR_data_withdescriptions.txt": contains descriptive variable names
      * "UCI_HAR_data_withdescriptions.txt": tidy data set with the average of each variable for each activity and each subject
      * Clean up global environment in R, so no junk is left behind
