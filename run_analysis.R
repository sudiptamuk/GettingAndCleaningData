run_analysis <- function() {

        ##This program assumes to be in a folder in the same level as "test" and
        ##"train" folder and all other common files like "activity_labels.txt"
        ##and "features.txt" to run. If not we have to set the working directory
        ##appropriately through setwd() command and run this.
        
        ##Begin of common data for Activity levels and Features--------------------------
        ##Read the activity levels into a table
        activity_labels_tb <- read.table("activity_labels.txt", header = FALSE);
        no_of_activities <- nrow(activity_labels_tb);
        
        ##Create meaningful Activity Data
        meaningful_activity_labels_vec <- c("Walking", 
                                            "Walking Upstairs", 
                                            "Walking Downstairs",
                                            "Sitting",
                                            "Standing",
                                            "Laying"
                                            )
        ##Create meaningful Activity Data
        activity_labels_tb[,2] <- meaningful_activity_labels_vec;

                        
        ##Read the features into a table
        features <- read.table("features.txt");
        
        ##Create a features vector that witll hold the features                
        features_vec <- features[,2];        
        
        ##End of processing common info for "test" and "train"
        
        ## Begin of reading "test" folder data--------------------------------------------
        
        ##Read y_test data table
        y_test_tb <- read.table("test/y_test.txt", header = FALSE);
        
        ##Read x_test data table
        x_test_tb <- read.table("test/x_test.txt", header = FALSE);
        
        colnames(x_test_tb) <- features_vec;
        
        ##Read subject test data table
        subject_test_tb <- read.table("test/subject_test.txt", header = FALSE);
        
        y_test_activity <- y_test_tb;
        ##Character conversion from factor for activity levels.
        for(j in 1:nrow(y_test_activity)){
                        
                y_test_activity[j,] <- as.character(activity_labels_tb$V2[y_test_tb[j,]]);
                        
        }
        ##Add Activity column to test data set
        x_test_tb["Activity"] = y_test_activity;
        ##Add subject data column to train data set
        x_test_tb["Subject"] = subject_test_tb;
        
        ##End of procesing "test" folder data--------------------------------------
        
        ##Begin processing training data-------------------------------------------

        ##Read test data table
        y_train_tb <- read.table("train/y_train.txt", header = FALSE);
        
        ##Read x_test table
        x_train_tb <- read.table("train/X_train.txt", header = FALSE);
        

        
        features_vec <- features[,2];
        
        colnames(x_train_tb) <- features_vec;
        
        ##Read subject training table
        subject_train_tb <- read.table("train/subject_train.txt", header = FALSE);
        
        no_of_activities <- nrow(activity_labels_tb);
        
        y_train_activity <- y_train_tb;
        ##Character conversion from factor for activity levels.
        for(j in 1:nrow(y_train_activity)){
                
                y_train_activity[j,] <- as.character(activity_labels_tb$V2[y_train_tb[j,]]);
                
        }
        ##Add Activity column to train data set
        x_train_tb["Activity"] = y_train_activity;
        ##Add subject data column to train data set
        x_train_tb["Subject"] = subject_train_tb;
        
        ##End of procesing "train" folder data--------------------------------------
        
        ##Merge both "test" and "train" folder data
        merged_data <- rbind(x_test_tb, x_train_tb)
        
        ##Get all 561 column names of the combined table
        merged_columns <- names(merged_data)
        
        ##Filter out only the columns with mean() and std() and of course Activity and Subject
        filtered_columns <- grep("mean|std|Activity|Subject", merged_columns, perl=TRUE, value=TRUE);
        
        ##Select only the required columns into a data frame
        selected_data <- merged_data[, filtered_columns];

        ##Create a vector of 79 + 2 items with text based meaningful column names to describe the column data
        meaningful_col_names <- c("Mean of Time Body Accelerometer X Direction", 
                                  "Mean of Time Body Accelerometer Y Direction",
                                  "Mean of Time Body Accelerometer Z Direction",
                                  "Standard Dev of Time Body Accelerometer X Direction",
                                  "Standard Dev of Time Body Accelerometer Y Direction",
                                  "Standard Dev of Time Body Accelerometer Z Direction",
                                  "Mean of Time Gravity Accelerometer X Direction", 
                                  "Mean of Time Gravity Accelerometer Y Direction",
                                  "Mean of Time Gravity Accelerometer Z Direction",
                                  "Standard Dev of Time Gravity Accelerometer X Direction", 
                                  "Standard Dev of Time Gravity Accelerometer Y Direction",
                                  "Standard Dev of Time Gravity Accelerometer Z Direction",
                                  "Mean of Time Body Accelerometer Jerk X Direction", 
                                  "Mean of Time Body Accelerometer Jerk Y Direction",
                                  "Mean of Time Body Accelerometer Jerk Z Direction",
                                  "Standard Dev Time Body Accelerometer Jerk X Direction", 
                                  "Standard Dev Time Body Accelerometer Jerk Y Direction",
                                  "Standard Dev Time Body Accelerometer Jerk Z Direction",
                                  "Mean of Time Body Gyroscope X Direction", 
                                  "Mean of Time Body Gyroscope Y Direction",
                                  "Mean of Time Body Gyroscope Z Direction",
                                  "Standard Dev of Time Body Gyroscope X Direction", 
                                  "Standard Dev of Time Body Gyroscope Y Direction",
                                  "Standard Dev of Time Body Gyroscope Z Direction", ##24
                                  "Mean of Time Body Gyroscope Jerk X Direction", 
                                  "Mean of Time Body Gyroscope Jerk Y Direction",
                                  "Mean of Time Body Gyroscope Jerk Z Direction",
                                  "Standard Dev of Time Body Gyroscope Jerk X Direction", 
                                  "Standard Dev of Time Body Gyroscope Jerk Y Direction",
                                  "Standard Dev of Time Body Gyroscope Jerk Z Direction", ##30
                                  "Mean of Time Body Accelerometer Mag", 
                                  "Standard Dev of Time Body Accelerometer Mag",
                                  "Mean of Time Gravity Accelerometer Mag",
                                  "Standard Dev of Time Gravity Accelerometer Mag",
                                  "Mean of Time Body Accelerometer Jerk Mag", 
                                  "Standard Dev of Time Body Accelerometer Jerk Mag", ##36
                                  "Mean of Time Body Gyroscope Mag", 
                                  "Standard Dev of Time Body Gyroscope Mag",
                                  "Mean of Time Body Gyroscope Jerk Mag", 
                                  "Standard Dev of Time Body Gyroscope Jerk Mag", ##40
                                  "Mean of Fourier Body Accelerometer X Direction", 
                                  "Mean of Fourier Body Accelerometer Y Direction",
                                  "Mean of Fourier Body Accelerometer Z Direction",
                                  "Standard Dev of Fourier Body Accelerometer X Direction", 
                                  "Standard Dev of Fourier Body Accelerometer Y Direction",
                                  "Standard Dev of Fourier Body Accelerometer Z Direction",##46
                                  "Mean Frequency of Fourier Body Accelerometer X Direction", 
                                  "Mean Frequency of Fourier Body Accelerometer Y Direction",
                                  "Mean Frequency of Fourier Body Accelerometer Z Direction",##49
                                  "Mean of Fourier Body Accelerometer Jerk X Direction", 
                                  "Mean of Fourier Body Accelerometer Jerk Y Direction",
                                  "Mean of Fourier Body Accelerometer Jerk Z Direction",##52
                                  "Standard Dev of Fourier Body Accelerometer Jerk X Direction", 
                                  "Standard Dev of Fourier Body Accelerometer Jerk Y Direction",
                                  "Standard Dev of Fourier Body Accelerometer Jerk Z Direction",##55
                                  "Mean Frequency of Fourier Body Accelerometer Jerk X Direction", 
                                  "Mean Frequency of Fourier Body Accelerometer Jerk Y Direction",
                                  "Mean Frequency of Fourier Body Accelerometer Jerk Z Direction",##58
                                  "Mean of Fourier Body Gyroscope X Direction", 
                                  "Mean of Fourier Body Gyroscope Y Direction",
                                  "Mean of Fourier Body Gyroscope Z Direction", ##61
                                  "Standard Dev of Fourier Body Gyroscope X Direction", 
                                  "Standard Dev of Fourier Body Gyroscope Y Direction",
                                  "Standard Dev of Fourier Body Gyroscope Z Direction", ##64
                                  "Mean Frequency of Fourier Body Gyroscope X Direction", 
                                  "Mean Frequency of Fourier Body Gyroscope Y Direction",
                                  "Mean Frequency of Fourier Body Gyroscope Z Direction",##67
                                  "Mean of Fourier Body Accelerometer Mag", 
                                  "Standard Dev of Fourier Body Accelerometer Mag",##69
                                  "Mean Frequency of Fourier Body Accelerometer Mag", 
                                  "Mean of Fourier Body Body Accelerometer Jerk Mag",
                                  "Standard Dev of Fourier Body Body Accelerometer Jerk Mag",##72
                                  "Mean Frequency of Fourier Body Body Accelerometer Jerk Mag",
                                  "Mean of Fourier Body Body Gyroscope Mag",##74
                                  "Standard Dev of Fourier Body Body Gyroscope Mag",
                                  "Mean Frequency of Fourier Body Body Gyroscope Mag",##76
                                  "Mean of Fourier Body Body Gyroscope Jerk Mag",
                                  "Standard Deviation of Fourier Body Body Gyroscope Jerk Mag",##78
                                  "Mean Frequency of Fourier Body Body Gyroscope Jerk Mag",##79
                                  "Activity", ## Added Acticity data for each row.
                                  "Subject" ## Added subject data for each row.
                                  )
        
        ##Assign the column names to the selected data table
        colnames(selected_data) <- meaningful_col_names;
        
        ##Create a sorted vector of Subjects to help in creating tidy data set
        subjectVector <- sort(unique(selected_data$Subject));

        ##Create a String vector of Activities to help in creating tidy data set
        activityVector <- sapply(activity_labels_tb$V2, as.character);

        ##Create an empty tidy data frame with an objective of having one row
        ##for each of "Subject", "Activity", "Variable" with its mean value.
        tidyData <- data.frame(data.frame(matrix(nrow=0, ncol=4)));
        
        #Assign meaningful column names to the tidy data frame
        colnames(tidyData) <- c("Subject", "Activity", "Variable", "Mean");
        
        ##Initialize a row number integer to add rows in processed tidy data frame
        rowNum <- 1;

        ##Populate the tidy data Frame. This is done through three levels of for loop.
        ##The first level is filter by "Subject", the second level is filter further
        ##by "Activity", and the last is "mean" of each column. In the last phase
        ##one row of tidy data gets created and populated in the tidy data frame
        ##with the rowNum variable. The rowNum is incremented after each population
        ##to insert data into next row.
        for(i in 1:length(subjectVector)){
                aSubjectData <- subset(selected_data, Subject == subjectVector[i]);
                for(j in 1:length(activityVector)){
                        aActivityData <- subset(aSubjectData, Activity == activityVector[j]);
                        NoOfCols <- length(meaningful_col_names) - 2;
                        for(k in 1: NoOfCols){
                                tidyData[rowNum,1] <- subjectVector[i];
                                tidyData[rowNum,2] <- activityVector[j];
                                tidyData[rowNum,3] <- meaningful_col_names[k];
                                tidyData[rowNum,4] <- mean(aActivityData[,k]);
                                rowNum <- rowNum + 1;
                        }
                }
                
        }

        ##Wite the tidy data set in a text file. This should have each row with one
        ##subject, one Activity, one variable and corresponding mean value.
        write.table(tidyData, file="TidyDataSet.txt", row.name=FALSE);

}