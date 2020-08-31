##This Script does the following:
##1-Merges the data sets:
X<-rbind(X_test,X_train)
Y<-rbind(y_test, y_train)
Subject <- rbind(subject_test , subject_train)
merged <-  cbind(Subject ,Y , X)
##2-Extracts only the measurements on the mean and standard deviation for 
## each measurement.
tidy <- merged %>% select(subjects , code , contains("mean"), contains("std"))
##3- Uses descriptive activity names to name the activities in the data set
tidy$code <- activity_labels[tidy$code, 2]
##4- Appropriately label the data set with descriptive variable names. 
names(tidy)[2] = "activity" 
names(tidy)<-gsub("Acc", "Accelerometer", names(tidy))
names(tidy)<-gsub("Gyro", "Gyroscope", names(tidy))
names(tidy)<-gsub("BodyBody", "Body", names(tidy))
names(tidy)<-gsub("Mag", "Magnitude", names(tidy))
names(tidy)<-gsub("^t", "Time", names(tidy))
names(tidy)<-gsub("^f", "Frequency", names(tidy))
names(tidy)<-gsub("tBody", "TimeBody", names(tidy))
names(tidy)<-gsub("-mean()", "Mean", names(tidy), ignore.case = TRUE)
names(tidy)<-gsub("-std()", "STD", names(tidy), ignore.case = TRUE)
names(tidy)<-gsub("-freq()", "Frequency", names(tidy), ignore.case = TRUE)
names(tidy)<-gsub("angle", "Angle", names(tidy))
names(tidy)<-gsub("gravity", "Gravity", names(tidy))
##5-  From the data set in step 4, creates a second, independent tidy data 
##set with the average of each variable for each activity and each subject.
FinalData <- tidy %>% group_by(subjects, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

