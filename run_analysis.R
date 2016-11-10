#read files
names <- read.table("UCI HAR Dataset/features.txt")
data <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = "numeric")
subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
activity <- read.table("UCI HAR Dataset/train/y_train.txt")

data1 <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = "numeric")
subject1 <- read.table("UCI HAR Dataset/test/subject_test.txt")
activity1 <- read.table("UCI HAR Dataset/test/y_test.txt")

#build full data set
names(data) <- names$V2
data["subject"]<- subject$V1
data["activity"] <- activity$V1
names(data1) <- names$V2
data1["subject"]<- subject1$V1
data1["activity"] <- activity1$V1

# Merges the training and the test sets to create one data set.
data <- rbind(data, data1)

# Extracts only the measurements on the mean and 
# standard deviation for each measurement.
i_means <- grep("mean", names$V2)
i_stds <- grep("std", names$V2)
data <- data[ c(i_means, i_stds, 562, 563)]

# Uses descriptive activity names to name the activities in the data set
data["activity"] <- factor(data$activity, labels = 
        c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

# second data set with the average of each variable for each activity 
# and each subject.
data <- by(data[1:79], list(data$activity, data$subject), colMeans, simplify = TRUE)
data <- simplify2array(data)
data <- as.data.frame(t(data))
data[["activity"]]<- rep(1:6)
data["activity"] <- factor(data$activity, labels = 
        c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
data[["subject"]]<- rep(1:6, each=30)
data <- data[, c(80, 81, 1:79)]

write.table(data, "tidy.txt", row.names = FALSE) 