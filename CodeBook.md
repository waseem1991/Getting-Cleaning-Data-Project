My Course Project Code Book
======================

This is the code book for my course project for Coursera course [Getting and Cleaning Data](https://www.coursera.org/course/getdata) taught by [Professor Jeffrey Leek](http://www.biostat.jhsph.edu/~jleek/research.html).


Data Source Attribution
---------------------------

The raw data utilized to make the tidy data set presented here represent data collected from the accelerometer and gyroscope signals from the Samsung Galaxy S smartphone. A full description and attribution is available at the site where the data was originally obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The specific zipped file containing the raw data set for this project was provided by the class instructors.



Details
---------
There were 30 individual subjects in the test. They are represented by the arbitrary values of numbers one through thirty as identifying indicators (`subject ids`).

Accelerometer and gyroscope readings were analyzed for six types of activities: 
- walking
- walking_upstairs
- walking_downstairs
- sitting
- standing
- laying


The means and standard deviations for 66 measures have been averaged over time for each test subject. Specifically,my handling of the original data resulted in only collecting the measures of `mean()` and `std()` for each measure and required the measure have both. Some measures that included the term `mean` were not included here as a result because the derived data set described here is only dealing with the means and accompanying standard deviations of the assessements of the measures.

There are no units for these measures as they are in fact ratios derived by dividing by their range to normalize the data. (See discussion posting https://class.coursera.org/getdata-004/forum/thread?thread_id=261#comment-880 for more information,)


On a related note, as described in [this post](https://class.coursera.org/getdata-004/forum/thread?thread_id=106), the data in the inertial directory of the original data provided was very raw data and did not include means with accompanying standard deviations that were the subject of collection and analysis here, and so it has been left out of the derived data set described here.


The sixty-six measures for which the averages for each test subject and activity analyzed are featured in the data set:

mean acceleration of the body in x-axis of the phone  
mean acceleration of the body in y-axis of the phone  
mean acceleration of the body in z-axis of the phone  
std deviation of acceleration of the body in x-axis of the phone  
std deviation of acceleration of the body in y-axis of the phone  
std deviation of acceleration of the body in z-axis of the phone  
mean acceleration of gravity in x-axis of the phone  
mean acceleration of gravity in y-axis of the phone  
mean acceleration of gravity in z-axis of the phone  
std deviation of acceleration of gravity in x-axis of the phone  
std deviation of acceleration of gravity in y-axis of the phone  
std deviation of acceleration of gravity in z-axis of the phone  
mean acceleration during jerk signals of the body in x-axis of the phone  
mean acceleration during jerk signals of the body in y-axis of the phone  
mean acceleration during jerk signals of the body in z-axis of the phone  
std deviation of acceleration during jerk signals of body in x-axis of the phone  
std deviation of acceleration during jerk signals of body in y-axis of the phone  
std deviation of acceleration during jerk signals of body in z-axis of the phone   
mean angular velocity of the body in x-axis of the phone  
mean angular velocity of the body in y-axis of the phone  
mean angular velocity of the body in z-axis of the phone  
std deviation of angular velocity of the body in x-axis of the phone  
std deviation of angular velocity of the body in y-axis of the phone  
std deviation of angular velocity of the body in z-axis of the phone  
mean angular velocity during jerk signals of the body in x-axis of the phone  
mean angular velocity during jerk signals of the body in y-axis of the phone  
mean angular velocity during jerk signals of the body in z-axis of the phone  
std deviation of angular velocity during jerk signals of body in x-axis of the phone  
std deviation of angular velocity during jerk signals of body in y-axis of the phone  
std deviation of angular velocity during jerk signals of body in z-axis of the phone  
mean magnitude of the acceleration of the body  
std deviation of the magnitude of the acceleration of the body  
mean magnitude of the acceleration of gravity  
std deviation of the magnitude of the acceleration of gravity  
mean magnitude of the acceleration of the body during jerk signals  
std deviation of the magnitude of the acceleration of the body during jerk signals   
mean magnitude of the angular velocity of the body  
std deviation of the magnitude of the angular velocity of the body  
mean magnitude of the angular velocity of the body during jerk signals  
std deviation of the magnitude of the angular velocity of the body during jerk signals  
mean frequency domain signals of the acceleration of the body in x-axis of the phone  
mean frequency domain signals of acceleration of the body in y-axis of the phone  
mean frequency domain signals acceleration of the body in z-axis of the phone  
std deviation of the frequency domain signals of acceleration of the body in x-axis of the phone  
std deviation of the frequency domain signals of acceleration of the body in y-axis of the phone  
std deviation of the frequency domain signals of acceleration of the body in z-axis of the phone   
mean frequency domain signals during jerk signals for the acceleration of the body in x-axis of the phone  
mean frequency domain signals during jerk signals for the acceleration of the body in y-axis of the phone  
mean frequency domain signals during jerk signals for the acceleration of the body in z-axis of the phone  
std deviation of the frequency domain signals during jerk signals for the acceleration of the body in x-axis of the phone  
std deviation of the frequency domain signals during jerk signals for the acceleration of the body in y-axis of the phone  
std deviation of the frequency domain signals during jerk signals for the acceleration of the body in z-axis of the phone  
mean frequency domain signals of the angular velocity of the body in x-axis of the phone  
mean frequency domain signals of angular velocity of the body in y-axis of the phone  
mean frequency domain signals angular velocity of the body in z-axis of the phone  
std deviation of the frequency domain signals of angular velocity of the body in x-axis of the phone  
std deviation of the frequency domain signals of angular velocity of the body in y-axis of the phone  
std deviation of the frequency domain signals of angular velocity of the body in z-axis of the phone   
mean magnitude of the frequency domain signals of the acceleration of the body  
std deviation of the frequency domain signals of the magnitude of the acceleration of the body  
mean magnitude of the frequency domain signals of the maganitude of acceleration of the body during jerk signals  
std deviation of the frequency domain signals of the magnitude of the acceleration of the body during jerk signals  
mean magnitude of the frequency domain signals of the angular velocity of the body  
std deviation of the frequency domain signals of the magnitude of the angular velocity of the body  
mean magnitude of the frequency domain signals of the angular velocity of the body during jerk signals  
std deviation of the frequency domain signals of the magnitude of the angular velocity of the body during jerk signals  


 

 

The standard deviation is abbreviated `std deviation`. Those measures indicated with `acceleration` pertain to readings from the accelerometer and those referencing `angular velocity` are from the gyroscope readings. The differentiation into signals from the body and gravity are maintained as in the original feature descriptors.  Jerk signals are described with descriptor `during jerk signals`.
I have used indicated those derived from Fast Fourier Transforms (FFTs) as pertaining to `frequency domain signals` and those where the magnitude (See the original `features_info.txt` for more information.)

I want to comment on my choices for descriptive variables names. For tidy data, the course stresses it is best to keep variable names clear but avoid periods, underscores, or whitespaces. However, in this case I have chosen to include white space as a compromise because the terms describing these variables are in large part very similar as they deal with the phones' acclerometer and gryoscrope readings, and it would be very difficult to make these variable names descriptive otherwise.  

It was requested for this project that variable names in the colmumns of the measures be particularly descriptive and they are. The column names of the measurements, while not conforming precisely to the course recommendations of column and row names, i.e., avoid whitepsace, periods, and underscores in names, represent a compromise between keeping them clear and human readable. Also in being very descriptive they are a bit verbose for my tastes since the terms are all rather similar and this approach was encouraged by the TA for the course (see https://class.coursera.org/getdata-004/forum/thread?thread_id=106#post-402), I arrived at these names.

The names were based on information in the following files from the original data set:
- `features.txt` 
- `features_info.txt` and 
- `README.txt` 




Transformations and fixes
--------------------------
The provided training and testing data sets were merged to create a single combined data set. For further work, I limited the data set to only include data related to mean or standard deviation values (denoted by the presence of `mean()` or `std()` in the feature names) as described above.  

The averages of the means and standard deviations for each activity for each individual test subject were calculated and are presented in the tidy data set `tidy_data_of_means.txt`.

####Details of fixes addressed
While there weren't many mistakes that I saw. One fixed in the course of making the variable names of the measures better involved the variable names. For example, the `features_info.txt` file listed that there should be `fBodyAccJerkMag` but that doesn't occur in the original provided features listing in `features.txt`. Instead there is `fBodyBodyAccJerkMag`  in `features.txt`. Likewise, a similar phenomena occurs for several of the last variable names listed towards the end of the list of variable names in `features.txt`. (The list itself encompasses lines 13 to 29 of that file.)
  



Accessing the data set 
------------------------
The tidy data set produced should be downloadable via the link provided by Coursera.
After downloading, the tidy data set can be read in by 

    data_read <- read.table("tidy_data_of_means.txt")
    
However, when the whitespaces I had in my varaible names gets converted to periods, or at least show up as such when the table `data_read` is viewed in rStudio. However, if you view the `tidy_data_of_means.txt` separately in a text editor, you'll see the spaces.

  
  
  

Additional information 
---------------------------------------
My `run_analysis.R` script was used to take a provided untidy data set and make the tidy data set described in this code book. Learn more about it [here](https://github.com/fomightez/clean_data_course_proj/blob/master/README.md).
######The script includes many comments and I would suggest consulting it [here](https://github.com/fomightez/clean_data_course_proj/blob/master/run_analysis.R) if you still seek additional insight about the processing of the raw data to a tidy data set after consulting the [README.md file](https://github.com/fomightez/clean_data_course_proj/blob/master/README.md).
  
  
  
  
  
  
  
#### Additional notes on the data set targeted to issues specific to course goals
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




