Raw test data were read into the dataframes using header = FALSE and sep = "":
  test_subjects
  test_data
  test_labels

Raw train data were read into the dataframes using header = FALSE and sep = "":
  train_subjects
  train_data
  train_labels

Features were read into the following data fram using header = FALSE, and sep = "" and the first column was dropped
  features

The activity labels were read into the dataframe:
  activities

The column name "Subject" was added to:
  test_subjects; and
  train_subjects.
  
The column name "Activity" was added to:
  test_labels; and
  train_labels.

The dataframe features was used to assign column names to: 
  test_data; and
  train_data.

Using rbind, new dataframes were created by appending train data below the test data:
  combined_subjects;
  combined_data; and
  combined_labels

Using grep any features not containing 'std' or 'mean' were dropped.

To make the data tidier (and to satisfy step 4, 'Appropriately labels the data set with descriptive variable names') the preceding t in column names was replaced with
'Time Domain' and f with 'FrequencyDomain.  The symbols '-', ')', ',' and'(' were also removed from the feature names.  Some words beginning with a lower case letter 
were replaced with the same word beginning with a capital letter.

The combined_subjects, combined_labels, and combined_data data frames were then column bound to form:
  combined_all

Using the gsub function, the numbers in combined_all$Activity were replaced with the appropriate activity descriptions.

This tidy data set was then written to 'Combined.csv'

Using dplyr, the following data frame was created by grouping the combined_all datafram on Subject and Activity:
  summary_with_mean

The final step was to write summary_with_mean to the file 'Summary_with_Mean.csv'.
