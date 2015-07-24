# Getting-and-Cleaning-Data
For assignment submission for Getting and Cleaning Data
1.Load the required library for executing this code

2.Read and load the train data, train data, features and activity labels into RStudio

=>train_data_X 
=>train_data_Y 
=>subject_train 
=>test_data_X 
=>test_data_Y 
=>subject_test 
=>features
=>activity_labels

3. Bind the labels to Y_Train Data

4. Bind the labels to X_Train Data

5. Use column bind to bind the Y_Train Data and X_Train Data into training dataset 

6. Bind the labels to Y_Test Data

7. Bind the labels to X_Test Data

8. Use column bind to bind the Y_Test Data and X_Test Data into test dataset 

9. Use row bind to bind the training and test data into a full dataset

10. Use melt function from reshape package to alter the data presentation style 

11. Use the dcast function from reshape package to cast the data to compute the mean of the dataset

12. Use the write.table to export out the output into a tidy_data.txt text file

