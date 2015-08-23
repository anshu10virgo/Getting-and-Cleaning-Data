==================================================================
Getting-and-Cleaning-Data
Coursera R Programming Assignment for third Course

==================================================================
Steps to run:

The folder named 'UCI HAR Dataset' need to be kept in the current working directory to make the script working

There is one other script named 'readTxt.R' which contain a function to read the files in train and test data in one go. So this function need to be loaded first in the workspace. Code for this is already included in the run_analysis.R

To read the tidy dataset(named uci_final_dataset.txt) into workspace that is submitted in the project use the following command:
read.table("uci_tidy_data.txt",header = TRUE)

==================================================================
Assumptions:

I have taken into consideration the columns with name like mean() and std() resulting into 66 columns and 2 other columns of Subject and Activity. The reason all mean like column were not taken is because the columns like 'meanFreq()' were weighted average of the frequency component, resulting into mean frequency and not the mean of the linear acceleration or angular velocity components. 

The othe features like angle() were also not taken into account as these vectors were obtained byh averaging signals in signal window sample and not wer the average of the signals as it is.

==================================================================
Algorithm:

