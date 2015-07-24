#library(dplyr)
library(data.table)
library(reshape2)
## Read the training data
train_data_X <- read.table("~/R Workspace/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
train_data_Y <- read.table("~/R Workspace/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("~/R Workspace/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
  
## Read the test data
test_data_X <- read.table("~/R Workspace/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
test_data_Y <- read.table("~/R Workspace/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
subject_test <- read.table("~/R Workspace/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")

## Read the features 
features <- read.table("~/R Workspace/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
## Read the label 
activity_labels <- read.table("~/R Workspace/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")

##Binding the labels to Y_Train Data
subject_id<- rename(subject_train, subject_id=V1)

train<- cbind(train_data_Y,subject_id)
train_dt<- merge(train,activity_labels, by=("V1"))
colnames(train_dt)<- c("Activity_ID","Subject","Activity")

##Binding the label for X_Train Data
colnames(train_data_X)<- features[,2]

##Building the training dataset
train_data <- cbind(train_dt,train_data_X)
extract_train <-names(train_data)[grep("mean|std", names(train_data))] 
train_data_final <- cbind(train_data[,c(2,1,3)],train_data[,c(extract_train)])

##Binding the labels to Y_Test Data
subject_id<- rename(subject_test, subject_id=V1)
test<- cbind(test_data_Y,subject_id)
test_dt<- merge(test,activity_labels, by=("V1"))
colnames(test_dt)<- c("Activity_ID","Subject","Activity")

##Binding the label for X_Test Data
colnames(test_data_X)<- features[,2]

##Building the test dataset
test_data <- cbind(test_dt,test_data_X)
extract_test <-names(test_data)[grep("mean|std", names(test_data))] 
test_data_final <- cbind(test_data[,c(2,1,3)],test_data[,c(extract_test)])

##Merging the training and test dataset
full_data <- rbind(train_data_final,test_data_final)


##To create the tidy dataset
id_labels   = c("Subject", "Activity_ID", "Activity")
data_labels = setdiff(colnames(full_data), id_labels)
melt_data      = melt(full_data, id = id_labels, measure.vars = data_labels)

tidy_data   = dcast(melt_data, Subject + Activity ~ variable, mean)