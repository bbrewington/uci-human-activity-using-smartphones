# Code Book for UCI Human Activity Using Smartphones

## Data
Data comes from this zip file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The information below was copied & pasted from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##  Variables
There are 2 types of variables referred to below: Label Variables (for identifying experimental conditions) and Motion Variables (numeric data with absolute value <= 1, showing different dynamical aspects of the motion of the smartphone)
  * Label Variables
     * **subject**: integer value, 1-30, each value signifying a unique subject in the study
     * **activity_id**: integer value, 1-6
        * 1 WALKING
        * 2 WALKING_UPSTAIRS
        * 3 WALKING_DOWNSTAIRS
        * 4 SITTING
        * 5 STANDING
        * 6 LAYING
  * Motion Variables
     * In the UCI HAR dataset, there are 561 motion variables, 79 of which have either "mean" or "std" in their name, and do not have "angle" in their name. These 79 variables were chosen for the tidy data set, and variables were re-named according to the schema shown below in the "Variable Name" section

Motion Variable Name = [domain].[acceleration signal].[device].[type of variable].[summary statistic]
* Motion Variable Name Elements
   * [domain]: **time** or **frequency**
   * [acceleration signal]: **body** or **gravity**
   *  [device]: **accelerometer** or **gyroscope**
   * [type of variable]: one of the 4 choices shown in the list below
      * **3axial[modifier]**
        * [modifier] = X, Y, or Z appended to end
      * **magnitude**
      * **jerk3axial[modifier]**
        * [modifier] = X, Y, or Z appended to end
      * **jerkmagnitude**
   * [summary statistic]: **mean**, **meanFreq**, or **stdev** 

Example variable name: time.body.accelerometer.3axialX.mean

There was a typo in the variable names, where some variables had the word "Body" repeated twice.  This was treated as one instance of "Body".  For example, the variable in line 516 of "features.txt" is labeled as "fBodyBodyAccJerkMag-mean()".  This was interpreted as "fBodyAccJerkMag-mean()"

## Transformations performed on data
1. Data was read from the zip file shown above, and the following data files were combined together into a data frame in R:
   * X_train.txt
   * X_test.txt
   * y_train.txt
   * y_test.txt
   * activity_labels.txt
   * features.txt

2. The variables with names containing "mean" or "std" were then extracted
3. From this extracted data, the mean was performed on each variable with groupings by both subject & activity_id
