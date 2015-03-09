
# The goal of this script is to provide a solution to assigment for Getting and Cleaning Data course on Coursera.
# Results of this assignment are stored in variable "all" and "all2"

##################################################################################################################

library("plyr")
library("dplyr")
library("reshape2")
library("tidyr")

#step 1 and 2
#reading label data    ------------------------------------------------------------------------------------------

feat <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE, col.names= "subject")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE, col.names= "subject")

# reading and filtering test file //-----------------------------------------------------------------------------

testlab <- read.table("./UCI HAR Dataset/test/Y_test.txt")
colnames(testlab) <- "activity_id"
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(test) <- feat[,2]
test <- test[,(grepl("mean",colnames(test)) | grepl("std", colnames(test))) & !grepl("meanFreq", colnames(test))]
test <- cbind(testlab,subtest,test)

# reading and filtering train file-------------------------------------------------------------------------------

trainlab <- read.table("./UCI HAR Dataset/train/Y_train.txt")
colnames(trainlab) <- "activity_id"
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(train) <- feat[,2]
train <- train[,(grepl("mean",colnames(train)) | grepl("std", colnames(train))) & !grepl("meanFreq", colnames(train))]
train <- cbind(trainlab,subtrain,train)

# adding test and train variables -------------------------------------------------------------------------------

test <- mutate(test, set = "test")
train <- mutate(train, set = "train")

# creating one datafile (step 1) --------------------------------------------------------------------------------
all <- rbind(test,train)

# Step 3 and 4 ##################################################################################################

all <- melt(all, id.vars = c("activity_id", "subject", "set"))
all$activity_id <- mapvalues(all$activity_id, c(1,2,3,4,5,6),c("Walking",
                                                               "Walking_upstaires",
                                                               "Walking_downstairs",
                                                               "Sitting",
                                                               "Standing",                                                               
                                                               "Laying"))

#step 5 #########################################################################################################

all2 <- aggregate(all$value, by = list(all$variable,
                                       all$activity_id,
                                       all$subject), FUN = mean)

colnames(all2) <- c("variable", "activity", "subject", "mean_value")

 # creating new filters. Data will be more clear and user will be able to easily filter among different variables.
 # Initial rough feature description is still available in the first column. 
 # --------------------------------------------------------------------------------------------------------------

all2 <- separate(all2,variable, sep = "-", into = c("new_variable","value_type", "axis"), extra = "drop",remove = FALSE)
all2 <- separate(all2,new_variable, into = c("time_or_ftt", "new_variable"), sep = 1)

all2$value_type <- mapvalues(all2$value_type, c("mean()", "std()"), c("mean","std"))
all2$motion_type <- ifelse(grepl("Body",all2$new_variable),"body", "gravity")
all2$device <- ifelse(grepl("Acc",all2$new_variable),"accelerometer", "gyroscope")
all2$jerk <- ifelse(grepl("Jerk",all2$new_variable),TRUE,FALSE)
all2$mag <- ifelse(grepl("Mag",all2$new_variable),TRUE,FALSE)

 # final select and text file creation -------------------------------------------------------------------------
all2 <- select(all2,variable,activity,subject,mean_value,value_type, time_or_ftt,motion_type:mag,axis)
write.table(all2, "run_analysis.txt", row.name = FALSE)



