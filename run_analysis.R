# add needed libraries
library(tidyverse)
library(dplyr)

# read the test data
test_subjects <- read.csv('./test/subject_test.txt', sep = "", header=FALSE)
test_data <- read.csv('./test/X_test.txt', sep = "", header=FALSE)
test_labels <- read.csv('./test/Y_test.txt', sep = "", header=FALSE)

# read the train data
train_subjects <- read.csv('./train/subject_train.txt', sep = "", header=FALSE)
train_data <- read.csv('./train/X_train.txt', sep = "", header=FALSE)
train_labels <- read.csv('./train/Y_train.txt', sep = "", header=FALSE)

# read the features info
features <- read.csv('./features.txt', sep = "", header=FALSE)
#write.csv(features, 'features_start_new.csv', row.names = FALSE)
features = features[,2]

#write.csv(features, 'features_start2.csv', row.names = FALSE)

# read the activities info
activities <- read.csv('./activity_labels.txt', sep = "")


# check dimensions
dim(test_subjects)
dim(test_data)
dim(test_labels)

dim(train_subjects)
dim(train_data)
dim(train_labels)

# add column names
colnames(test_subjects) = c("Subject")
colnames(train_subjects) = c("Subject")

colnames(test_labels) = c("Activity")
colnames(train_labels) = c("Activity")

#write.csv(features, 'features.csv', row.names = FALSE)

colnames(test_data) = features
colnames(train_data) = features

# row bind the test and train data
combined_subjects <- rbind(test_subjects, train_subjects)
combined_data <- rbind(test_data, train_data)
combined_labels <- rbind(test_labels, train_labels)

# check dimensions 
dim(combined_subjects)
dim(combined_data)


dim(combined_all)


# drop features that don't have 'mean' or 'std'

keep <- grep("std|mean", features, ignore.case = TRUE)

combined_data <- combined_data[, keep]

# replace t with Time Domain and f with Frequency Domain
colnames(combined_data) <- gsub("^t", "TimeDomain", colnames(combined_data))
# replace t with Time Domain and f with Frequency Domain
colnames(combined_data) <- gsub("^f", "FrequencyDomain", colnames(combined_data))
# get rid of -, (, and )
colnames(combined_data) <-gsub("-", "", colnames(combined_data))
colnames(combined_data) <-gsub("\\(", "", colnames(combined_data))
colnames(combined_data) <-gsub("\\)", "", colnames(combined_data))
# upper case start for mean, std, gravity and angle
colnames(combined_data) <-gsub("mean", "Mean", colnames(combined_data))
colnames(combined_data) <-gsub("std", "StdDev", colnames(combined_data))
colnames(combined_data) <-gsub("angle", "Angle", colnames(combined_data))
colnames(combined_data) <-gsub(",gravity", "andGravity", colnames(combined_data))

# now column bind the subjects, labels, and data
combined_all <- cbind(combined_subjects, combined_labels, combined_data)


# use gsub to replace label numbers with activities

for (num in 1:6){
  combined_all$Activity <- gsub(num, activities[num,2], combined_all$Activity)
}

write.csv(combined_all, 'Combined.csv', row.names = FALSE)


# calculate means (use dplyr)
    # of each variable
    # for each subject and each activity

summary_with_mean <- combined_all %>% group_by(Subject, Activity) %>% 
    summarise(across(everything(), list(mean)))

write.csv(summary_with_mean, 'Summary_with_Mean.csv', row.names = FALSE)

