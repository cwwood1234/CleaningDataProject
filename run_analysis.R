######################################
# Script name:  run_analysis.R
# Date created:  24 October 2014
# Author:  Craig Wood
#
# This script performs the following functions on the Samsung data set:
#
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names. 
#   5. From the data set in Step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

# Step 1:  Merge the training and test sets to create on data set:

# Open the X and Y data sets
x_train <- read.table("X_train.txt", header = FALSE)
y_train <- read.table("Y_train.txt", header = FALSE)
x_test <- read.table("X_test.txt", header = FALSE)
y_test <- read.table("Y_test.txt", header = FALSE)

# Open the Subject data sets
subject_train <- read.table("subject_train.txt", header = FALSE)
subject_test <- read.table("subject_test.txt", header = FALSE)

# Bind the Training data sets together
training_data <- cbind(x_train, subject_train, y_train)

# Bind the Test data sets together
test_data <- cbind(x_test, subject_test, y_test)

# Bind the Training and Test data sets together
master_data <- rbind(training_data, test_data)

# Add variable names to all 563 columns of the Master data set
variable_names <- read.table("features.txt", header = FALSE)
colnames(master_data) <- variable_names[,2]
colnames(master_data)[562:563] <- c("Subject","Activity")


# Step 2:  Extract the 48 measurements on the mean and standard deviation, and the Subject and Activity:
keeps<-c(1:6, 41:46, 81:86, 121:126, 161:166, 266:271, 345:350, 424:429, 562:563)
master_data <- master_data[keeps]


# Step 3:  Use descriptive names to name the activities in the data set:
activity_labels <- read.table("activity_labels.txt", header = FALSE, sep = " ")
master_data["Activity_label"] <- NA
for (i in 1:nrow(master_data)) {
        master_data[i,51] <- toString(activity_labels[master_data[i,50],2])
        master_data[i,52] <- toString(c(master_data[i,49],master_data[i,51]))
}


# Step 4:  Label the data set with descriptive variable names:
colnames(master_data)[1] <- "timeBodyAccelerationMeanX"
colnames(master_data)[2] <- "timeBodyAccelerationMeanY"
colnames(master_data)[3] <- "timeBodyAccelerationMeanZ"
colnames(master_data)[4] <- "timeBodyAccelerationStdX"
colnames(master_data)[5] <- "timeBodyAccelerationStdY"
colnames(master_data)[6] <- "timeBodyAccelerationStdZ"
colnames(master_data)[7] <- "timeGravityAccelerationMeanX"
colnames(master_data)[8] <- "timeGravityAccelerationMeanY"
colnames(master_data)[9] <- "timeGravityAccelerationMeanZ"
colnames(master_data)[10] <- "timeGravityAccelerationStdX"
colnames(master_data)[11] <- "timeGravityAccelerationStdY"
colnames(master_data)[12] <- "timeGravityAccelerationStdZ"
colnames(master_data)[13] <- "timeBodyAccelerationJerkMeanX"
colnames(master_data)[14] <- "timeBodyAccelerationJerkMeanY"
colnames(master_data)[15] <- "timeBodyAccelerationJerkMeanZ"
colnames(master_data)[16] <- "timeBodyAccelerationJerkStdX"
colnames(master_data)[17] <- "timeBodyAccelerationJerkStdY"
colnames(master_data)[18] <- "timeBodyAccelerationJerkStdZ"
colnames(master_data)[19] <- "timeBodyGyroMeanX"
colnames(master_data)[20] <- "timeBodyGyroMeanY"
colnames(master_data)[21] <- "timeBodyGyroMeanZ"
colnames(master_data)[22] <- "timeBodyGyroStdX"
colnames(master_data)[23] <- "timeBodyGyroStdY"
colnames(master_data)[24] <- "timeBodyGyroStdZ"
colnames(master_data)[25] <- "timeBodyGyroJerkMeanX"
colnames(master_data)[26] <- "timeBodyGyroJerkMeanY"
colnames(master_data)[27] <- "timeBodyGyroJerkMeanZ"
colnames(master_data)[28] <- "timeBodyGyroJerkStdX"
colnames(master_data)[29] <- "timeBodyGyroJerkStdY"
colnames(master_data)[30] <- "timeBodyGyroJerkStdZ"
colnames(master_data)[31] <- "frequencyBodyAccelerationMeanX"
colnames(master_data)[32] <- "frequencyBodyAccelerationMeanY"
colnames(master_data)[33] <- "frequencyBodyAccelerationMeanZ"
colnames(master_data)[34] <- "frequencyBodyAccelerationStdX"
colnames(master_data)[35] <- "frequencyBodyAccelerationStdY"
colnames(master_data)[36] <- "frequencyBodyAccelerationStdZ"
colnames(master_data)[37] <- "frequencyBodyAccelerationJerkMeanX"
colnames(master_data)[38] <- "frequencyBodyAccelerationJerkMeanY"
colnames(master_data)[39] <- "frequencyBodyAccelerationJerkMeanZ"
colnames(master_data)[40] <- "frequencyBodyAccelerationJerkStdX"
colnames(master_data)[41] <- "frequencyBodyAccelerationJerkStdY"
colnames(master_data)[42] <- "frequencyBodyAccelerationJerkStdZ"
colnames(master_data)[43] <- "frequencyBodyGyroMeanX"
colnames(master_data)[44] <- "frequencyBodyGyroMeanY"
colnames(master_data)[45] <- "frequencyBodyGyroMeanZ"
colnames(master_data)[46] <- "frequencyBodyGyroStdX"
colnames(master_data)[47] <- "frequencyBodyGyroStdY"
colnames(master_data)[48] <- "frequencyBodyGyroStdZ"


# Step 5:  Create an independent tidy data set with the average of each variable for each activity and each subject:
output_table <- data.frame(matrix(NA, nrow=180, ncol=49))
names(output_table) <- c("SubjectActivity",colnames(master_data[1:48]))

# Create the reference index in Column 1:  Subject + Activity Label
counter <- 1
for (i in 1:30) {
        for (j in 1:6) {
                output_table[counter,1] <- toString(c(i,toString(activity_labels[j,2])))
                counter <- counter + 1
        }
}

# Use the reference index to populate all fields in the output_table
for (i in 1:180) {
        for (j in 2:49) {
                output_table[i,j] <- with(master_data, mean(master_data[,j-1][V52 == output_table[i,1]]))
        }
}

# Write the output_table to a .txt file for uploading to Coursera
write.table(output_table, file = "output_table.txt", row.name = FALSE)