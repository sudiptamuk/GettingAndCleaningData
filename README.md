Getting And Cleaning Data Project Information README file.
---------------------------------------------------------------------------------

This document refers to the information about the run_analysis.R program file that
will read the wearable computing data set, process and clean to create further 
usable tidy data.

----------------------------------------------------------------------------------
Run environment:
This program assumes to be in a folder in the same level as "test" and
"train" folder and all other common files like "activity_labels.txt"
and "features.txt" to run. If not, we have to set the working directory
appropriately through setwd() command and run this.
For example a typical work directory should be like this.
UCI HAR Dataset\run_analysis.R
UCI HAR Dataset\activity_labels.txt
UCI HAR Dataset\features.txt
UCI HAR Dataset\features_info.txt
UCI HAR Dataset\test<folder>\<test data files>
UCI HAR Dataset\train<folder>\<train data files>

----------------------------------------------------------------------------------
Summary of the program:
This program first reads the different data text files and get them into data table
objects. The activity data are then replaced with meaningful text information easy
to comprehend. First test and then train folder data are read. They are then merged
and combined into one dataset.The variable names are translated into easy readable
texts and the table headers are replaced with those texts.Then the required columns
that has standard deviation and mean are then picked up. Lastly the selected data
set are processed in multi level loops to create a tidy data set that has one subject
one activity and one variable mean in each row.

-------------------------------------------------------------------------------------
Variables used and their meaning:
activity_labels_tb = The Activity levels read from activity_labels.txt file.
no_of_activities = The number of Activities present(Count of rows in activity_labels.txt).
meaningful_activity_labels_vec = Meaningful texts of the Activites.
features = The features data read from "features.txt" file.
features_vec = The actual features extracted from features variable.
y_test_tb = Variable that holds data read from y_test.txt file.
x_test_tb = Variable that holds data read from x_test.txt file.
subject_test_tb = Variable that holds data from subject_test.txt file.
y_test_activity = The actual activites extracted from y_test_tb variable.
y_train_tb = Variable that holds data read from y_train.txt file.
x_train_tb = Variable that holds data read from x_train.txt file.
subject_train_tb = Variable that holds data read from subject_train.txt file.
no_of_activities = Number of rows in Activity_labels_tb variable.
y_train_activity = The actual activites extracted from y_train_tb variable.
merged_data = The merged data set from test and train folder.
merged_columns = The column names for all 561 + 2(Subject and Activity) variables.
filtered_columns = The required columns that has standard deviation and mean(And Subject and Activity).
selected_data = The full data set only for the filtered_Columns.
meaningful_col_names = The meaningful text representation for selected columns.
subjectVector = The sorted numeric subject vector for processing data for tidy data. 
activityVector = The activity dataset to process merged data to tidy data.
tidyData = The processed easy readable tidy data.

---------------------------------------------------------------------------------------

Description of steps to get tidy data:
1. 1-31 Lines are to read data from activities and features. A vector of text representation
of activity levels are created and populated with the activity data.
2. Line 33-58 are reading data from test folder. The Activites and Subjects are added to the
table of test data(Line 54 and 56).
3. Line 33-58 are reading data from train folder. The Activites and Subjects are added to the
table of training data(Line 54 and 56).
4. Line 94 is merging of test and train data into a merged data variable.Line 97 to get all the
column names.
5. Line 100 is getting the filtered columns which has std() (Standard Deviation) and mean()
in it.
6. Line 103 the selected data of the filtered columns.
7. Line 106 is the creation of a vector with meaningful text data of the variables.Line 190 is the
assignment of them to the merged data.
8. Line 193 and 196 are getting the SUbjects and activites to filter and process to get tidy data.
9. Line 198 to 203 are creation of a tidy data dataframe.
10. Initialize of a numeric variable that denotes each row number of tidy data.
11. 208-229 A 3 level deep "for loop"s are there to create the tidy data dataframe. 
The first level is for each subject, second level is for each activity and third level is for 
each variable that is there in a column. The mean is calculated in the third level and 
populated in the tidy data frame along with the subject, activity and variable name. 
Line 220-223 is the data population code.The rowNum variable is incremented to populate a new
row in the data frame.
12. Line 232 is to write the data frame output to a txt file. The text will have tidy data
that represents a unique Subject, a unique Activity and unique Variable combination in each row.

-----------------------------------------------------------------------------------------------

Files used:

R program File: UCI HAR Dataset\run_analysis.R
Code Book File: CodeBookForVariables.txt
Tidy Data Set File: TidyDataSet.txt

------------------------------------------------------------------------------------------------