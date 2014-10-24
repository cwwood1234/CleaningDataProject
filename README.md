## Synopsis

run_analysis.R computes means for all mean/standard deviation variables for all subjects and all activities in the "Human Activity Recognition Using Smartphones Data Set"

The original data and background information are available at the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Motivation

The project is intended to produce a single tidy data set which summarizes a large amount of raw subject data.  The tidy data set includes descriptive variable names in a 180 row by 49 column data frame.

## Dependencies

The following eight input files must be saved in your R working directory in order for the script to run correctly:

1. activity_labels.txt
2. features.txt
3. subject_test.txt
4. subject_train.txt
5. X_test.txt
6. X_train.txt
7. y_test.txt
8. y_train.txt

## Output

The script will produce a single output file, saved to your R working directory.  The output file is called **output_table.txt**.

The output file is a space delimimted text file which can be read back into R using the following command:

`df <- read.table("output_table.txt", sep=" ", head = TRUE)`


