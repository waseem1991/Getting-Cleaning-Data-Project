My Course Project
======================

This is my course project for Coursera course [Getting and Cleaning Data](https://www.coursera.org/course/getdata) taught by [Professor Jeffrey Leek](http://www.biostat.jhsph.edu/~jleek/research.html).

This repository includes three items:
----------------------

* An well-commented R script called `run_analysis.R` that does the analysis and creates the tidy data set for the phone data. 

>Details of the `run_analysis.R` script are provided below this accounting of the repository. 


* CodeBook.md 

>A markdown file that a code book that describes the variables, the data, and the transformations and work that I performed to clean up the data.

* README.md

>This file. It explains how the scripts work, contents of the repository, and how the contents are connected. 



###Details on the `run_analysis.R` script

The `run_analysis.R` script is a well-commented R script that does the analysis and creates the tidy data set by doing the following:

>1.  Merges the training and the test sets to create one data set. 
>2.  Extracts only the measurements on the mean and standard deviation for each measurement.
>3.  Uses descriptive activity names to name the activities in the data set
>4.  Appropriately labels the data set with descriptive variable names.
>5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The `run_analysis.R` script assumes the contents of the provided zip file have all been placed in the working directory at the outset. The specific files and directories from the instructor-provided zip file placed in the working directory:  
a) README.txt;  
b) activity_labels.txt;  
c) features_info.txt;  
d) features.txt;  
e) train directory; and  
f) test directory.

The `run_analysis.R` script requires the `reshape2` package for running. 
> That package will need to be install if issuing the command `library(reshape2)` causes issues.


####Step #1 information

As described in [this post](https://class.coursera.org/getdata-004/forum/thread?thread_id=106) the data in the inertial directory is very raw data and will ultimately be discarded for the tidy data set in later steps, and so it has been left out of the merge from the start.

In the raw data the test and the training data sets are actually divided among three files for each set. As preparation for the merge, steps combining the parts of the test and training data each into its own data frame precedes thse merging the training and test sets. During the combining the columns for subject ids and activity are added and converted from the interger values created during reading of the table to factor variables since the number differences don't correspond to quantitative differences. (I am using the term 'merge' here in the metaphorical sense and not referring to the R merge command, which is for combining horizontally related data sets that share a common key variable. I use `rbind` and `cbind` to clip together the sets in my script.) 

At the conclusion of the merge, the data set was checked for missing values as one should be congnizant of these when cleaning data and handle appropriately during downstream processes of creating a tidy data set or subsequent analysis. Luckily this is made easy by the fact there are no missing values.

####Step #2 information

From this point on, I will only be dealing with a subset of the data from the original data set. My handling of the data collected only the measures of `mean()` and `std()` for each measure and required the measure have both. Some measures that included the term mean were not included here as a result. I justify limiting my data to those where only `mean` and `std` accompanies each other in the list found in the file `features.txt` as I am moving towards creating a tidy data set that deals with these assessements of the measures.
 

####Step #3 information

Prior to my work the activity column was populated with numbers representing each activity. The correspondences were detailed in the file `activity_labels.txt`. In the data set I produced as part of step three, and subsequently, the more descriptive text labels of the activity have been incoporated instead. I used a function `addLabels` (included in the script) that altered the level designators of the factor variables to do this.
 
####Step #4 information

I want to comment on my choices for descriptive variables names. For tidy data the course stresses it is best to keep variable names clear but avoid periods, underscores, or whitespaces. However, in this case I have chosen to include white space as a compromise because the terms describing these variables are in large part very similar as they deal with the phones' acclerometer and gryoscrope readings, and it would be very difficult to make these variable names descriptive otherwise.  
The names were based on information in the files:
- `features.txt` 
- `features_info.txt` and 
- `README.txt` 

####Step #5 information
The final step uses the `melt` and `dcast` commands to reformat the data applying a function to evaluate the means for each
measurement for each activity and each subject. This is the part of the script dependent on the `reshape2` package for running. 
>That package will need to be installed if issuing the command `library(reshape2)` causes issues.

The reformatted data represents a tidy data set because:
- There is one variable per column.  
(2 columns of subject indicators and activity labels plus 66 columns of measures.)
- There is a single observation per row, meaning in this tidy data set there is a single subject and single activity with summary of the means collected for all the measures collected for that set on a single row.  
There are 180 rows because there are 6 activities that had been monitored for 30 individual subjects of the study. (6 * 30 = 180).
- The table hold elements of only one kind.  
Here that is the averages for a collection of measures for each subject and activity. This is also an improvement over the ariginal data set provided in that the data is in a single table instead of three. (Technically it is six files but they were arbitrarily split to have two sets they could train there assessment computations on and test the results on later.)
- Column names are easy to use and informative.  
It was requested for this project that variable names in the colmumns of the measures be particularly descriptive and they are. The column names of the measurements, while not conforming precisely to the course recommendations of column and row names, i.e., avoid whitepsace, periods, and underscores in names, represent a compromise between keeping them clear and human readable.
- Obvious mistakes in the data have been removed.
While there weren't many mistakes that I saw. One fixed in the course of making the variable names of the measures better involved the variable names. For example, the `features_info.txt` file listed that there should be `fBodyAccJerkMag` but that doesn't occur in the original provided features listing in `features.txt`. Instead there is `fBodyBodyAccJerkMag`  in `features.txt`. Likewise, a similar phenomena occurs for several of the last variable names listed towards the end of the list of variable names in `features.txt`. (The list itself encompasses lines 13 to 29 of that file.)
- Variable values are internally consistent.  
Similar process were applied to all variables and so they are consistent in this tidy data table.
- Appropriate transformed variables have been added.  
The averages of the means and standard deviations were added to the table and in fact the individual components were left off of the tidy data set.
(The properties referenced here are summarized from [here](http://www.r-bloggers.com/data-analysis-class/).)



The tidy data set produced can be read in by 

    data_read <- read.table("tidy_data_of_means.txt")
    
However, when the whitespaces I had in my varaible names gets converted to periods, or at least show up as such when the table `data_read` is viewed in rStudio. However, if you view the `tidy_data_of_means.txt` separately in a text editor, you'll see the spaces.

######The script includes many comments and I would suggest consulting it [here](https://github.com/fomightez/clean_data_course_proj/blob/master/run_analysis.R) if you still seek additional insight about the processing of the raw data to a tidy data set.

Dependencies
---------------------------------------
The `run_analysis.R` script requires the `reshape2` package for running. 
> The `reshape2` package will need to be install if issuing the command `library(reshape2)` causes issues.


Additional information and source attribution
---------------------------------------

The raw data utilized here represent data collected from the accelerometer and gyroscope signals from the Samsung Galaxy S smartphone. A full description and attribution is available at the site where the data was originally obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The specific zipped file containing the raw data set for this project was provided by the class instructors.



