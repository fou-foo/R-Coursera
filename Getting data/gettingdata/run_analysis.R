

############          be careful fixing your path

##rememner that the path must to terminate with "UCI HAR Dataset"
path<-"your_working_directory"

#first we load the data 
data<-read.table(file=paste(path,"/train/X_train.txt",sep=""))
features_test<-read.table(file=paste(path,"/test/X_test.txt",sep=""))

##as we know the order of the data corresponds to its label we can put together the features but taking care the order

data[7353:10299,]<-features_test[1:2947,]



#second we load labels for the train set
label_train<-read.table(file=paste(path,"/train/y_train.txt",sep=""))
temp_label<-label_train$V1

##and load label for the test set

label_test<-read.table(file=paste(path,"/test/y_test.txt",sep=""))
temp_label[7353:10299]<-as.numeric(label_test$V1)

data$Activity<-temp_label


#third we load the id of the subjects in the experiment

id_train<-read.table(file=paste(path,"/train/subject_train.txt",sep=""))
temp_id<-id_train$V1

##and load id for subjects the test set

id_test<-read.table(file=paste(path,"/test/subject_test.txt",sep=""))
temp_id[7353:10299]<-as.numeric(id_test$V1)

data$Person<-factor(temp_id)
#we change the value of the id for words in this way:
#   1 WALKING
#   2 WALKING_UPSTAIRS
#   3 WALKING_DOWNSTAIRS
#   4 SITTING
#   5 STANDING
#   6 LAYING
data$Activity<-factor(data$Activity,labels=c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))




#we used de library dply to manipulate easily the dataframe "data"
library(dplyr)
tidy<-select(data,Activity,Person,V1,V4,V2,V5,V3,V6,V121,V124,V122,V125,V123,V126)

TidyData<-group_by(tidy,Activity,Person)



PrintTidyData<-summarize(TidyData,
                         Average_Mean_Acc_X=mean(V1),Average_STD_Acc_X=mean(V4),
                         Average_Mean_Acc_Y=mean(V2),Average_STD_Acc_Y=mean(V5),
                         Average_Mean_Acc_Z=mean(V3),Average_STD_Acc_Z=mean(V6),
                         Average_Mean_Gyro_X=mean(V121),Average_STD_Gyro_X=mean(V124),
                         Average_Mean_Gyro_Y=mean(V122),Average_STD_Gyro_Y=mean(V125),
                         Average_Mean_Gyro_Z=mean(V123),Average_STD_Gyro_X=mean(V126))
                         

write.table(PrintTidyData,file=paste(path,"/PrintTidyData.txt",sep=""))
