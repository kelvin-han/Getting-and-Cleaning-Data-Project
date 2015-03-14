library(reshape2)

dataFileName <- "data.txt"
activity <- c("Walking", "WalkingUpstairs", "WalkingDownstairs", "Sitting", "Standing", "Laying")

# Step 1: Merges the training and the test sets to create one data set
# Read traindata into respective train dataframes
trainDataSubject <- read.table("./train/subject_train.txt", sep="", header=FALSE)
trainDataY <- read.table("./train/Y_train.txt", sep="", header=FALSE)
trainDataX <- read.table("./train/X_train.txt", sep="", header=FALSE)

# Read test data into respective test dataframes
testDataSubject <- read.table("./test/subject_test.txt", sep="", header=FALSE)
testDataY <- read.table("./test/Y_test.txt", sep="", header=FALSE)
testDataX <- read.table("./test/X_test.txt", sep="", header=FALSE)

# Combine respective dataframes by rows
dataSubjectCombine <- rbind(trainDataSubject,testDataSubject)
dataYCombine <- rbind(trainDataY,testDataY)
dataXCombine <- rbind(trainDataX,testDataX)

# Combine dataframes by columns to get a single dataframe
dataCombine <- cbind(dataSubjectCombine,dataYCombine,dataXCombine)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
featureNames <- read.table("./features.txt", sep=" ", header=FALSE, stringsAsFactors=FALSE)
featureNames <- featureNames[,-1]
addHeader <- c("Subject","Activity")
featureNames <- append(addHeader,featureNames)
meanstd <- grepl("Subject|Activity|mean|std", featureNames, perl=TRUE)
dataCombine <- dataCombine[,meanstd]

# Step 3: Uses descriptive activity names to name the activities in the data set
for (i in 1:length(activity))
{
        temp <- dataCombine[,2] == i
        dataCombine[temp,2] <- activity[i]
}

# Step 4: Appropriately labels the data set with descriptive variable names.

# Use only feature names with mean and std
featureNamesMeanStd <- featureNames[meanstd]
cleanedFeatureNames <- featureNamesMeanStd

# Modify feature names for better readability 
for (i in 3:length(featureNamesMeanStd))
{
        cleanedFeatureNames[i] <- gsub("tBody","timeBody",cleanedFeatureNames[i])
        cleanedFeatureNames[i] <- gsub("tGravity","timeGravity",cleanedFeatureNames[i])
        cleanedFeatureNames[i] <- gsub("fBodyBody","freqBody",cleanedFeatureNames[i]) 
        cleanedFeatureNames[i] <- gsub("fBody","freqBody",cleanedFeatureNames[i])
        cleanedFeatureNames[i] <- gsub("mean","Mean",cleanedFeatureNames[i])
        cleanedFeatureNames[i] <- gsub("std","StdDev",cleanedFeatureNames[i])
        cleanedFeatureNames[i] <- gsub("[[:punct:]]","",cleanedFeatureNames[i]) 
}

# Apply column name change
colnames(dataCombine) <- cleanedFeatureNames

# Step 5: From the data set in step 4, creates a second, independent tidy data set 
#         with the average of each variable for each activity and each subject.

# Reshape data using melt and dcast. Alternative is to summarise then merge
dataCombineLong <- melt(dataCombine, id = c("Subject","Activity"))
dataCombineWide <- dcast(dataCombineLong, Subject + Activity ~ variable, mean)

# Write data to file 
write.table(dataCombineWide, dataFileName, row.names = FALSE, quote = FALSE)
