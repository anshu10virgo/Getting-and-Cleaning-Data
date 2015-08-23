=========================================================================
Getting-and-Cleaning-Data
Coursera R Programming Assignment for third Course

=========================================================================
Steps to run:

* The folder named 'UCI HAR Dataset' need to be kept in the current working directory to make the script working

* There is one other script named 'readTxt.R' which contain a function to read the files in train and test data in one go. So this function need to be loaded first in the workspace. Code for this is already included in the run_analysis.R

* To read the tidy dataset (named uci_final_dataset.txt) into workspace that is submitted in the project use the following command:
read.table ("uci_tidy_data.txt",header = TRUE)

=========================================================================
Assumptions:

* I have taken into consideration the columns with name like mean() and std() resulting into 66 columns and 2 other columns of Subject and Activity. The reason all mean like column were not taken is because the columns like 'meanFreq()' were weighted average of the frequency component, resulting into mean frequency and not the mean of the linear acceleration or angular velocity components. 

* The other features like angle() were also not taken into account as these vectors were obtained by averaging signals in signal window sample and not were the average of the signals as it is.

=========================================================================
Algorithm:

Here are the steps that were run in the script:

* The readTxt.R contains a function named readTxt which reads the text file using read.table. The path of the text file is passed as an argument to the function. The header is set to false in readTxt

* Then the absolute paths of the test data and the train data are saved in the variable named 'test_files' and 'train_files' respectively. The argument 'pattern = *.txt' ensures that path of only text files are stored

* The contents of features.txt and activity_labels.txt are stored in data.frame which are used later. Then only the second column is used as first column contains the row numbers and then stored in a character array.

* The function readTxt is then applied to the variable 'test_files' and 'train_files' which contained path of test and train data respectively using lapply to get a list of data.frame. The list contains three data.frames for files - Subject, X and Y for both test and train data.

* All the data frames of the above list are binded column wise to get the test and train data

* The test and train data are merged into 'uci_data' and headers are assigned to the data.frame from the features array.

* The regular expression is applied and the columns containing mean() and std() in their names are fetched using grepl function. Then a logical vector containg all the column header is formed usin 'or' operator. The column headers of (1,563) are set to true as they are the headers of 'Subject' and 'Activity'. Then data with only mean() and std() is put into data.frame 'uci_tidy_data'

* Then Activity labels are applied to the column 'Activity' and they are converted to factor variables.

* Descriptive variable names are assigned to the column headers using the sub function that substitute regular expressions with string. It includes removal of '()', replacing 'BodyBody' with 'Body', replacing 'Acc' with 'Linear', replacing 'Gyro' with 'Angular', replacing 'Mag' with 'Magnitude' and replacing '-' with '.'.

* The vector uci_measure consist of all column names except 'Subject' and 'Activity'

* Then data is melted using melt function with 'Subject' and 'Activity' as id variables and remaining variables as measure variables. The result is stored in uci_melt_data

* The final data is obtained by dcasting the melted data and using 'mean' as the function to get the mean of all the variables w.r.t 'Subject' and 'Activity'. The na.rm is set to TRUE in case there are any NA values. The result is stored in 'uci_final_dataset'

* Finally 'uci_final_dataset' is written to file 'uci_final_dataset.txt' and row.names is set to FALSE so that in txt file there should not be any of its own row numbers
