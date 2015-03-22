library(dplyr)

#read test data 
test<-read.table('test/X_test.txt');
y_test<-read.table('test/y_test.txt');
subject_test<-read.table('test/subject_test.txt')

#read train data

train<-read.table('train/X_train.txt');
y_train<-read.table('train/y_train.txt');
subject_train<-read.table('train/subject_train.txt');

#read feature list data
features<-read.table('features.txt');



# find  cloumns infeatures have mean() or std()
f_cloumns<-grep('std|mean',features[,2],fixed=FALSE);

#extrat mean and standard data from test set and train set
extract_test<-test[,f_cloumns];
extract_train<-train[,f_cloumns];

#Appropriately labels the data set with descriptive variable names.
y_test<-rename(y_test,'activityName'=V1);
y_train<-rename(y_train,'activityName'=V1);
subject_test<-rename(subject_test,'subject'=V1);
subject_train<-rename(subject_train,'subject'=V1);

# change the test and train variable names with number  and the detail can check the code book;
colnames(extract_test)<-f_cloumns;
colnames(extract_train)<-f_cloumns;


#cbind test data and traindata with subject and activity label;

ntest<-cbind(y_test,subject_test,extract_test);
ntrain<-cbind(y_train,subject_train,extract_train);

#rbind  test data and train data
ndata<-rbind(ntest,ntrain);

#Uses descriptive activity names to name the activities in the data set
names<-read.table('activity_labels.txt');
names<-names[,2];
ndata[,1]=names[ndata[,1]];

completeData<-aggregate(ndata[,3:81], list(ndata$subject,ndata$activityName), mean);
completeData<-rename(completeData,'activity'=Group.1);
completeData<-rename(completeData,'activity'=Group.2);
write.table(completeData,file = 'completeData.txt',row.names=FALSE);

