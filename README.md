#GettingandCleaningData
##Project – README

This is a description of what happens when the script “run_analysis.R” is run.

* Firstly the script checks if there is a directory in the working directory called data. If the data directory isn’t present, the code will create it.
* In the second step, the code downloads a zip file containing the data from:     		 				https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
And unzips the files.
* In the third step the code merges the training and the test datasets together using the rbind() function and storing the data “A”.
* Thereafter the features are loaded from the features.txt file and using the grep() function the mean and std are filtered and stored in “FeaturesSTDMEAN”
* Names in the variable "FeaturesSTDMEAN" are applied to the header of dataset “A” and several gsub() functions are run to tidy the headers.
* Next step is to load the “subject_train.txt” and “subject_test.txt” files and merge them together and storing the data in “B”.
* Activity labels are loaded as well and stored as “activity”. Using gsub() the data is tidied up and merged together with data “B”.
* Next step is to load the “y_train.txt” and “y_test.txt” files and merge them together and storing the data in “C”. Header in data “C” is assigned the name “subject”.
* Last step is to merge all the datasets (“C”,”B” and “A”) and export them using the write.table() function to the file "concatenated_data.txt"

 Heidrikur Bergsson
