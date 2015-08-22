
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

uci_data <- rbind(test_data,train_data)
uci_header <- cbind("Subject",t(features_header),"Activity")
names(uci_data) <- uci_header

mean_list <- grepl("[Mm]ean",uci_header)
std_list <- grepl("[Ss]td",uci_header)
df_list <- mean_list | std_list
df_list[c(1,563)] <- TRUE

uci_tidy_data <- uci_data[,uci_header[df_list]]
uci_tidy_data <- within(uci_tidy_data, Activity <- factor(Activity, labels = activity_labels))
names(uci_tidy_data) <- sub("\\(\\)","",names(uci_tidy_data))
