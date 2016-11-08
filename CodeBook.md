# Introduction

The script `run_analysis.R`performs the 5 steps described in the course project's definition.

* First, all data loaded and merged using the `rbind()` function. 
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. 
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `tidy.txt`, and uploaded to this repository.