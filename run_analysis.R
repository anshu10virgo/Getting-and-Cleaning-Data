library (reshape2)
source("./readTxt.R")
test_files <- list.files("./UCI HAR Dataset/test/",recursive = FALSE,pattern = "*.txt",full.names = TRUE)
train_files <- list.files("./UCI HAR Dataset/train/",recursive = FALSE, pattern = "*.txt",full.names = TRUE)

features <- read.table("./UCI HAR Dataset/features.txt",header = FALSE)
features_header <- as.character(features[,2])
activity <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)
activity_labels <- as.character(activity[,2])

list_of_test_data <- lapply(test_files, readTxt)
list_of_train_data <- lapply(train_files, readTxt)

test_data <- do.call(cbind,list_of_test_data)
train_data <- do.call(cbind,list_of_train_data)

# Step 1
uci_data <- rbind(test_data,train_data)
uci_header <- cbind("Subject",t(features_header),"Activity")
names(uci_data) <- uci_header

# Step 2
mean_list <- grepl("mean\\(\\)",uci_header)
std_list <- grepl("std\\(\\)",uci_header)
df_list <- mean_list | std_list
df_list[c(1,563)] <- TRUE
uci_tidy_data <- uci_data[,uci_header[df_list]]

# Step 3
uci_tidy_data <- within(uci_tidy_data, Activity <- factor(Activity, labels = activity_labels))

# Step 4
uci_tidy_header <- sub("\\(\\)","",names(uci_tidy_data))
uci_tidy_header <- sub("BodyBody{1}","Body",uci_tidy_header)
uci_tidy_header <- sub("Acc{1}","Linear",uci_tidy_header)
uci_tidy_header <- sub("Gyro{1}","Angular",uci_tidy_header)
uci_tidy_header <- sub("Mag{1}","Magnitude",uci_tidy_header)
uci_tidy_header <- gsub("-",".",uci_tidy_header)
names(uci_tidy_data) <- uci_tidy_header

# Step 5
uci_measure <- names(uci_tidy_data)[2:67]
uci_melt_data <- melt(uci_tidy_data, id.vars = c("Subject","Activity"), measure.vars = uci_measure)
uci_dcast_data <- dcast(uci_melt_data, Subject + Activity ~ variable, mean, na.rm = TRUE)

# Writing the data