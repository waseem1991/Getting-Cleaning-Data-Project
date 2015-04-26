## run_analysis.R
##
## Peforms the steps for the course project assigned in the course
## Getting and Cleaning Data in order to start with a set of untidy data
## and produce a tidy data set.



	## addLabels is a helper function to take a data frame and
	## change the factor variables that are currently represented as
	## numbers and replace them with the corresponding text according
	## to the file `activity_labels.txt`.
	## Summary of conversion table:
	##		No.		Corresponding Label for Activity
	## 		1  		walking
	##		2 		walking_upstairs
	## 		3 		walking_downstairs
	##		4 		sitting
	##		5 		standing
	##		6 		laying
	addLabels <- function(the_dataframe,col_involved) {
		# used two pages in R cook for help:
		# 1. http://www.cookbook-r.com/Manipulating_data/Renaming_levels_of_a_factor/
		# 2. http://www.cookbook-r.com/Manipulating_data/Mapping_vector_values/
		# also helpful was the tip I learned about the DOUBLE BRACKETS when
		# setting as factor variables earlier.
		# Turns out though I just needed to rename the levels. I thought I had to
		# propogate all the changes myself and had code to do it, like this:
		# levels(mean_std_data[[2]])[levels(mean_std_data[[2]])=="1"] <- "walking"
		# mean_std_data[[2]][mean_std_data[[2]]=="1"] <- "walking"
		#
		# But oddly when I finally did it on the big set I just needed to do the
		# levels command and changes propagated not just to names of levels, but
		# to rows of those levels. (I don't know why it didn't work in tests, but
		# I suspect I had been mixing and matching columns without factor
		# variables in development process of code.)
		levels(the_dataframe[[col_involved]])[levels(the_dataframe[[col_involved]])==
		"1"] <- "walking"
		levels(the_dataframe[[col_involved]])[levels(the_dataframe[[col_involved]])==
		"2"] <- "walking_upstairs"
		levels(the_dataframe[[col_involved]])[levels(the_dataframe[[col_involved]])==
		"3"] <- "walking_downstairs"
		levels(the_dataframe[[col_involved]])[levels(the_dataframe[[col_involved]])==
		"4"] <- "sitting"
		levels(the_dataframe[[col_involved]])[levels(the_dataframe[[col_involved]])==
		"5"] <- "standing"
		levels(the_dataframe[[col_involved]])[levels(the_dataframe[[col_involved]])==
		"6"] <- "laying"
		the_dataframe # to return the entire frame with changes done on column involved
	}






######### ------MAIN CODE STARTS HERE----------MAIN CODE STARTS HERE-------#####
###       THE SCRIPT ADDRESSES THE 5 STEPS IN THE COURSE PROJECT.          ####
## 1. Merging the training and the test sets to create one data set.
	## 1.a. First combine the three parts of the test data into one table.
	## 1.a.1. Read in the three parts
	test_set_subject_ids_as_table <- read.table("test/subject_test.txt")
	test_set_activities_as_table <- read.table("test/y_test.txt")
	test_set_measurements <- read.table ("test/X_test.txt", sep="") # Since
	# separation on "" is actually default, its inclusion here is in fact redundant.
	# ADDITIONAL NOTE ON ABOVE CODE: The TA's post of 6-22-14
	# (https://class.coursera.org/getdata-004/forum/thread?thread_id=371#comment-1246)
	# said suggested using 'header=FALSE' but I found it unnecessary.

	## 1.a.2. Add ids as first column to right of measurements and add
	## the activities as column 2
	test_table <- cbind (test_set_activities_as_table , test_set_measurements)
	colnames(test_table)[1] <- "activity" #In order to keep things straight I am
	# going to rename this column now. See more on adjusting names and labels
	# in step 3 and 4 below.

	#Now add the subject ids column
	test_table <- cbind (test_set_subject_ids_as_table , test_table)
	colnames(test_table)[1] <- "subjectid" #In order to keep things clear I am
	# going to rename this column now. Note that even though this is two words
	# I am not adding underscores or dots or white spaces, keeping in line with
	# the conventions highlighted at the end of lecture 1 of week 4 of class.
	# See more on adjusting names and text labels in later steps.


	## 1.b. Now do much the same steps for the training set in further preparation
	## for merging the test and training. (Used find/replace in a separate text
	## editor window to change all instance of 'test' to 'train'. Pasted back
	## just code lines below as process same as commented above.)
	train_set_subject_ids_as_table <- read.table("train/subject_train.txt")
	train_set_activities_as_table <- read.table("train/y_train.txt")
	train_set_measurements <- read.table ("train/X_train.txt", sep="")
	train_table <- cbind (train_set_activities_as_table , train_set_measurements)
	colnames(train_table)[1] <- "activity"
	train_table[1] <- factor(train_table[[1]])
	train_table <- cbind (train_set_subject_ids_as_table , train_table)
	colnames(train_table)[1] <- "subjectid"


	## 1.c. Now it is actually time for the merge.
	## 1.c.1. The rows of the two data.frames are combined to produce the merged data.
	merged_data <- rbind (train_table, test_table)
	## 1.c.2. Although I cannot find in writing on the slides reference to a
	## tidy data set being clearly ordered clarity is indeed one of the
	## properties of a tidy data set and the 1st lecture of week 3, entitled
	## `subsetting and sorting` discussed sorting tables in order as well. Thus,
	## I am going to arrange the table in an orderly manner, sorting by
	## subject id and activity.
	merged_data <- merged_data[order(merged_data$subjectid, merged_data$activity), ]
	## 1.c.3. The merge command ended up making row.names showing row
	## numbers reflecting the numbering before I re-ordered. I don't need that and
	## so I will remove it. See the next comand where I did.
	## ASIDE: Alternatively I could have done that with the command
	## `row.names(merged_data) <- seq(nrow(merged_data))` as described at
	## http://r.789695.n4.nabble.com/Remove-row-names-column-in-dataframe-td856647.html
	## and reminiscent of 'Creating Sequences' covered in `Creating New Variables`
	## lecture from week 3.
	row.names(merged_data) <- NULL
	## Actually since the numbers, currently intergers, in subject id and activity
	# columns are only meant to represent individuals and activities and do not
	# actually change quantitatively, they should be changed to factor variables.
	## (This is similar to what the instructor does with the zip codes on slide
	## 10 of the 'Creating New Variables' video lecture of week three and the
	## reasoning for doing it was the same.)
	merged_data[1] <- factor(merged_data[[1]]) # thanks for the question
	#http://stackoverflow.com/questions/14774382/r-error-x-must-be-atomic-for-sort-list
	# helping with formatting the command so I get a vector back and not a data
	# frame which I would get if I used single brackets.
	merged_data[2] <- factor(merged_data[[2]])
	## 1.c.4. Because the sign of a tidy data set is clean data and dealing with
	## the missingness, I checked if there was any missing values.
	## Turns out there are no missing values which makes things easier. The below
	## two lines are just to demonstrate that.
	missing_values <- sum(is.na(merged_data))
	print(paste("There are ", missing_values," missing values in the merged data.", collapse=""))


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
	## 2.a. I opened the 'features.txt' file and collected the numbers at start
	## of line for each that included 'mean()' or 'std()'. I only took those that had both
	## because as I read the directions you want each measuremnt that has those
	## and you want those values for those.
	## It sure was convenient they put the index numbers there so I didn't have to add
	## that first.
	## Note: I should have (and would have if I had more time to devote
	## to this class) written into this script to open the 'features.txt'
	## file and read them into a table where I read the row numbers into a vector
	## and added 2 to each (to account for the columns I added) and then appended it to
	## the vector 'c(1,2)' [to again account for the first two coliumns I added
	## and want to keep], but by the time I got that working perfectly I could have
	## used 5 times over used REGEX in my text editor to collect all the lines
	## including 'mean()' or 'std()'. So I did the collection using my
	## text editor and pasted that into here. If I thought I was going to do ever
	## do this or anything again vaguely similar again, I'd work more on making
	## it automated. And I still might. But not before the assignment is due.
	## REGEX USED IN TEXT EDITOR TO COLLECT THE LINES:
	## FIND:
	## ^(?:(?!mean\(\)|std\(\)).)*$\r?\n?
	##
	## REPLACE:
	## \1
	## Then with those 66 I made a sequence of the numbers I could build into a
	## vector in R.
	## So next in TEXT EDITOR TO GRAB JUST NUMBERS AT START OF LINE AND SET UP
	## ADDING '2' TO SHIFT OVER FROM EXTRA TWO COLUMNS I ADDED:
	## FIND:
	## ^(\d*).*
	## REPLACE:
	## , (\1 + 2),
	##
	## THEN IN TEXT EDITOR, REMOVED LINE BREAKS:
	## FIND:
	## \n
	## REPLACE WITH NOTHING
	##
	## THEN IN TEXT EDITOR, REMOVED DOUBLE COMMAS INTRODUCED DURING REGEX PROCESS:
	## FIND:
	## ,,
	## REPLACE:
	## ,
	##
	## Now I edited the ends of the text and placed into R as a vector of sixty-six
	## values, called `extracted`. Note, that the first number in paranthetical
	## set is the number from each line derived from 'features.txt'; the '+ 2' in
	## the second half is just to account for the 'subjectid' and 'activity' column
	## when it will be used to subset the merged_data.
	extracted_values_vector <- c((1 + 2), (2 + 2), (3 + 2), (4 + 2), (5 + 2), (6 +
		2), (41 + 2), (42 + 2), (43 + 2), (44 + 2), (45 + 2), (46 + 2), (81 +
		2), (82 + 2), (83 + 2), (84 + 2), (85 + 2), (86 + 2), (121 + 2), (122 +
		2), (123 + 2), (124 + 2), (125 + 2), (126 + 2), (161 + 2), (162 + 2), (163 +
		2), (164 + 2), (165 + 2), (166 + 2), (201 + 2), (202 + 2), (214 + 2), (215 +
		2), (227 + 2), (228 + 2), (240 + 2), (241 + 2), (253 + 2), (254 + 2), (266 +
		2), (267 + 2), (268 + 2), (269 + 2), (270 + 2), (271 + 2), (345 + 2), (346 +
		2), (347 + 2), (348 + 2), (349 + 2), (350 + 2), (424 + 2), (425 + 2), (426 +
		2), (427 + 2), (428 + 2), (429 + 2), (503 + 2), (504 + 2), (516 + 2), (517 +
		2), (529 + 2), (530 + 2), (542 + 2), (543 + 2) )
	first_two_columns_vector <-c(1,2) # want to keep because I put subject ids and activities there
	columns_to_keep_vector <- append (first_two_columns_vector, extracted_values_vector )
	## 2.b. Now that I know what columns I want to keep, get rid of the rest
	mean_std_data <- merged_data[ , columns_to_keep_vector]

## 3. Uses descriptive activity names to name the activities in the data set.
	## The activity column is currently populated with numbers representing each
	## activity. Next, though, the activity column should have those numbers
	## changed to the corresponding text values from the list in the
	## file 'activity_labels.txt'. Since these numbers were converted to
	## factor variables earlier (as they do not actually change in a quantitative
	## manner) I can use level factor handling to easily change the level designators.
	## I made a function in R to do this, called `addLabels`. It is at the top of
	## this script.
 	## I just need to provide the data set a column as argumnents in
 	## my call to the function.
	mean_std_data <- addLabels(mean_std_data, 2)

## 4. Appropriately labels the data set with descriptive variable names.
	## This step will rename the columns #3 through #68 of the mean_std_data.
	## Currently they are V1, V2, etc., with the number part of the name
	## corresponding to the same lines of the features.txt table I dealt
	## with earlier to get the measures involved in mean() and std() , see
	## step 2A. So I am going to go over to my text editor and open the
	## `features.txt` and I will go through finding the mean() and std()
	## values and use those very short names featuring those designations as
	## a basis for building descriptive variable names based on what I
	## learn in the `features_info.txt` and `README.txt` files.
	## Then I'll build vectors in easy to handle chunks to change the column names.
	## I'll verify I am changing the right ones to match by every so often
	## looking at the numbers after the 'V' in the current column names and
	## verifying they match the number in front of the short name in the file
	## `features.txt` that I am adapting at present. (I put this number as
	## as comment after the closing parantheses of several of column naming
	## commands to help me later in making the code book.)
	##
	## Now that the process has been covered, I'll address the name
	## choices I made. We are sort of tasked with a hard job here. For tidy data
	## the course stresses it is best to keep variable names clear but not
	## to contain periods, underscores, or whitespaces. However, in this case I
	## have chosen to include white space as a compromise because the very
	## similar nature of many of these variables it would be very
	## difficult to make these variable names descriptive otherwise. This will be
	## clearly noted in the README and code book accompanying this data.
	## Additionally, I would deem more choices to be very verbose for easy
	## use but I was encouraged to this solution by course TA, David Hood in his
	## posting https://class.coursera.org/getdata-004/forum/thread?thread_id=106#post-402
	colnames(mean_std_data)[3:5] <- c(
		"mean acceleration of the body in x-axis of the phone",
		"mean acceleration of the body in y-axis of the phone",
		"mean acceleration of the body in z-axis of the phone")
	colnames(mean_std_data)[6:8] <- c(
		"std deviation of acceleration of the body in x-axis of the phone",
		"std deviation of acceleration of the body in y-axis of the phone",
		"std deviation of acceleration of the body in z-axis of the phone")
	colnames(mean_std_data)[9:11] <- c(
		"mean acceleration of gravity in x-axis of the phone",
		"mean acceleration of gravity in y-axis of the phone",
		"mean acceleration of gravity in z-axis of the phone")
	colnames(mean_std_data)[12:14] <- c(
		"std deviation of acceleration of gravity in x-axis of the phone",
		"std deviation of acceleration of gravity in y-axis of the phone",
		"std deviation of acceleration of gravity in z-axis of the phone") #46
	colnames(mean_std_data)[15:17] <- c(
		"mean acceleration during jerk signals of the body in x-axis of the phone",
		"mean acceleration during jerk signals of the body in y-axis of the phone",
		"mean acceleration during jerk signals of the body in z-axis of the phone")
	colnames(mean_std_data)[18:20] <- c(
		"std deviation of acceleration during jerk signals of body
		in x-axis of the phone",
		"std deviation of acceleration during jerk signals of body
		in y-axis of the phone",
		"std deviation of acceleration during jerk signals of body
		in z-axis of the phone") #86
	colnames(mean_std_data)[21:23] <- c(
		"mean angular velocity of the body in x-axis of the phone",
		"mean angular velocity of the body in y-axis of the phone",
		"mean angular velocity of the body in z-axis of the phone")
	colnames(mean_std_data)[24:26] <- c(
		"std deviation of angular velocity of the body in x-axis of the phone",
		"std deviation of angular velocity of the body in y-axis of the phone",
		"std deviation of angular velocity of the body in z-axis of the phone") #126
	colnames(mean_std_data)[27:29] <- c(
		"mean angular velocity during jerk signals of the body in x-axis of the phone",
		"mean angular velocity during jerk signals of the body in y-axis of the phone",
		"mean angular velocity during jerk signals of the body in z-axis of the phone")
	colnames(mean_std_data)[30:32] <- c(
		"std deviation of angular velocity during jerk signals of body
		in x-axis of the phone",
		"std deviation of angular velocity during jerk signals of body
		in y-axis of the phone",
		"std deviation of angular velocity during jerk signals of body
		in z-axis of the phone") #166
	colnames(mean_std_data)[33:34] <- c(
		"mean magnitude of the acceleration of the body",
		"std deviation of the magnitude of the acceleration of the body") #202
	colnames(mean_std_data)[35:36] <- c(
		"mean magnitude of the acceleration of gravity",
		"std deviation of the magnitude of the acceleration of gravity") #215
	colnames(mean_std_data)[37:38] <- c(
		"mean magnitude of the acceleration of the body during jerk signals",
		"std deviation of the magnitude of the acceleration of the body during
		jerk signals") #228
	colnames(mean_std_data)[39:40] <- c(
		"mean magnitude of the angular velocity of the body",
		"std deviation of the magnitude of the angular velocity of the body") #241
	colnames(mean_std_data)[41:42] <- c(
		"mean magnitude of the angular velocity of the body during jerk signals",
		"std deviation of the magnitude of the angular velocity of the body
		during jerk signals") #254
	colnames(mean_std_data)[43:45] <- c(
		"mean frequency domain signals of the acceleration of the body in x-axis
		of the phone",
		"mean frequency domain signals of acceleration of the body in y-axis of
		the phone",
		"mean frequency domain signals acceleration of the body in z-axis of the
		phone")
	colnames(mean_std_data)[46:48] <- c(
		"std deviation of the frequency domain signals of acceleration of the
		body in x-axis of the phone",
		"std deviation of the frequency domain signals of acceleration of the
		body in y-axis of the phone",
		"std deviation of the frequency domain signals of acceleration of the
		body in z-axis of the phone") #271
	colnames(mean_std_data)[49:51] <- c(
		"mean frequency domain signals during jerk signals for the acceleration
		of the body in x-axis of the phone",
		"mean frequency domain signals during jerk signals for the acceleration
		of the body in y-axis of the phone",
		"mean frequency domain signals during jerk signals for the acceleration
		of the body in z-axis of the
		phone") #347
	colnames(mean_std_data)[52:54] <- c(
		"std deviation of the frequency domain signals during jerk signals for
		the acceleration of the body in x-axis of the phone",
		"std deviation of the frequency domain signals during jerk signals for
		the acceleration of the body in y-axis of the phone",
		"std deviation of the frequency domain signals during jerk signals for
		the acceleration of the body in z-axis of the phone") #424
	colnames(mean_std_data)[55:57] <- c(
		"mean frequency domain signals of the angular velocity of the body in x-axis
		of the phone",
		"mean frequency domain signals of angular velocity of the body in y-axis of
		the phone",
		"mean frequency domain signals angular velocity of the body in z-axis of the
		phone")
	colnames(mean_std_data)[58:60] <- c(
		"std deviation of the frequency domain signals of angular velocity of the
		body in x-axis of the phone",
		"std deviation of the frequency domain signals of angular velocity of the
		body in y-axis of the phone",
		"std deviation of the frequency domain signals of angular velocity of the
		body in z-axis of the phone") #429
	colnames(mean_std_data)[61:62] <- c(
		"mean magnitude of the frequency domain signals of the acceleration of
		the body",
		"std deviation of the frequency domain signals of the magnitude of the
		acceleration of the body") #504
	colnames(mean_std_data)[63:64] <- c(
		"mean magnitude of the frequency domain signals of the maganitude of
		acceleration of the body during jerk signals",
		"std deviation of the frequency domain signals of the magnitude of the
		acceleration of the body during jerk signals") #517
	colnames(mean_std_data)[65:66] <- c(
		"mean magnitude of the frequency domain signals of the angular velocity
		of the body",
		"std deviation of the frequency domain signals of the magnitude of the
		angular velocity of the body") #530
	colnames(mean_std_data)[67:68] <- c(
		"mean magnitude of the frequency domain signals of the angular velocity
		of the body during jerk signals",
		"std deviation of the frequency domain signals of the magnitude of the
		angular velocity of the body during jerk signals") #543


## 5. Creates a second, independent tidy data set with the average of each
##    variable for each activity and each subject.
	## From the `Reshaping Data` lecture of week 3, slide 5, it seems I want to use
	## use dcast to issue a function and reframe the data based on that. In fact,
	## example uses `mean` which happens to also be what is asked in the
	## course project.
	## I found very helpful http://seananderson.ca/2013/10/19/reshape.html ,
	## particularly two parts: (1) the beginning where it succinctly addressed
	## how to get a wide dataset cast the way you want you melt it into a narrow
	## one first, and (2)about halfway down as it illustrated with an example
	## giving dcast two id variables at the same time to use '+'
	## in between when using the actual dcast comamnd.
	##
	## 5.a. In preparation for casting the data, I'll melt it first so I
	## I can designate id variables. Hopefully the rest will be be taken as
	## values by default since according to help doc in rStudio
	## R tries to guess which ones are. (Otherwise
	## I would need to specify all except the first two column names. And
	## using `setdiff` like on next line might be the way to do that if need be:
	## measure.vars_vector <-setdiff(colnames(mean_std_data), c("subjectid","activity"))
	## and then I'd use that vector in measure.vars like on slide 4 of the week
	## 3 lecture `Reshaping Data`. --> readied_data <- melt(mean_std_data,
	## id.vars=c("subjectid", "activity"), measure.vars=measure.vars_vector))
	## ASIDE: When I first did the melt and dcast I ended up with only 64 columns
	## and not the 68 I had prior to that. Turns out I had a few column names
	## that ended up being the same due to copy/paste. These were easily
	## highlighted by using `table(names(mean_std_data))` and examining where
	## the value wasn't 1. I then went back and fixed the colnames commands above
	## in step 4 and re-ran the code. TA Scott von Kleeck helped me develop that
	## command, see https://class.coursera.org/getdata-004/forum/thread?thread_id=219#comment-1257
	library(reshape2)
	readied_data <- melt(mean_std_data, id.vars=c("subjectid", "activity"))
	## 5.b. Now can recast the data applying mean as a function.
	tidy_data_of_means <- dcast(readied_data, subjectid + activity ~ variable, mean)

	## The above line seemed to produce what we needed for the course project,
	## and follows much of the the tidy data properties nicely outlined at
	## http://www.r-bloggers.com/data-analysis-class/.

	## 5.c. Output the tidy data set.
	write.table(tidy_data_of_means, "tidy_data_of_means.txt")
	#This can be read in by `data_read <- read.table("tidy_data_of_means.txt")`,
	#but NOTE THAT WHEN THIS IS DONE the whitespaces I had in my varaible names
	#gets converted to periods, or at least show up as such when the table
	#`data_read` is viewed in rStudio..


