# Code Book for UCI Human Activity Using Smartphones

## Data
Data comes from this zip file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


##  Variables
### How variables were chosen:
  * Label Variables
     * *Definition*: variable describing the activity or subject
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
     * *Definition*: variable containing numeric decimal values (absolute value <= 1) describing motion of smartphone
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
