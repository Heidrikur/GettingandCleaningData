#check if folder "data" exists, if not created it.
if(!file.exists("./data")){dir.create("./data")}

#download file and unzip
zip.file <- "./data/dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile=zip.file) #,method="curl") mode="wb")
unzip(zip.file)

# 1. Merges the training and test datasets to create one data set
tempfile1 <- read.table("./UCI HAR Dataset/train/X_train.txt")
tempfile2 <- read.table("./UCI HAR Dataset/test/X_test.txt")
A <- rbind(tempfile1, tempfile2)


#2.Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./UCI HAR Dataset/features.txt")
featuresSTDMEAN <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

A <- A[, featuresSTDMEAN]
#Add features names to header
names(A) <- features[featuresSTDMEAN, 2]
#make all headernames in lowercase
names(A) <- tolower(names(A))
#Tidy up the headers
names(A) <- gsub("\\(|\\)", "", names(A))
names(A) <- gsub("-mean", "mean", names(A))
names(A) <- gsub("-std", "std", names(A))
names(A) <- gsub("-x", "x", names(A))
names(A) <- gsub("-y", "y", names(A))
names(A) <- gsub("-z", "z", names(A))
names(A) <- gsub("bodybody", "body", names(A))

# 3. Uses descriptive activity names to name the activities in the data set

#load and Merge dataset B
tempfile1 <- read.table("./UCI HAR Dataset/train/subject_train.txt")
tempfile2 <- read.table("./UCI HAR Dataset/test/subject_test.txt")
B <- rbind(tempfile1, tempfile2)

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
#remove underscores and set all activities in lowercase
activity[, 2] = gsub("_", "", tolower(as.character(activity[, 2])))
#assign activities to dataset B
B[,1] = activity[B[,1], 2]
#name header in dataset B "activity"
names(B) <- "activity"

# 4. Appropriately label the data set with descriptive activity names.

#load and merge dataset C
tempfile1 <- read.table("./UCI HAR Dataset/train/y_train.txt")
tempfile2 <- read.table("./UCI HAR Dataset/test/y_test.txt")
C <- rbind(tempfile1, tempfile2)

#Assign dataset B the header "subject"
names(C) <- "subject"
#merge dataset A,B and C together
concatenated <- cbind(C, B, A)

write.table(concatenated, "concatenated_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

