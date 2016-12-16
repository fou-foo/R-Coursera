# How run_analysis.R work

Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and unzip the packages in your directory. Then you should to find the path where this unziped packages is, you can do it with the right click in your mouse in the submenu "properties" and you can copy it.

The first thing you need to do is set the path:
  In the line 6 
  
  path<-"your_working_directory"

  you must to change the string "your_working_directory" for the path that you copy previously. Be Careful fixing your path because if you don't have the correct path that is your folder "UCI HAR Dataset" the script will not work.
  
Is very important note that all the files in the folder "train" has 7352 registers and the files in the folder "test" has 2947 registers.

In lines 9 the registers from the train is loaded and the dataframe "data" is defined.

In line 10 is readed and loaded the registers from the test.


How data structures are dynamics in line 14 we add to the data frame "data" which contains the data from the train, the registers from the test.

In lines 19 and 20 we load the "labels" from the registers in the training set and we save in temporaly in a variable "temp_label" .

In lines 24 and 25 we load the "labels" from the test set and we add to the tail of our temporaly variable "temp_label".

In line 27 add a new column to our dataframe "data" named it "Activity" and copy the content of "temp_label" to this new column.
 In lines 32-40 we load the subjects'id that were in the experiment analogously how we load the "labels" from the test and train set.
 
 In line 48 we cast the column "Person" which contains the persons'id  to a variable of type factor.
 
 In line 55 we define a new dataframe "tidy" which is a subset of the original dataframe "data". The list of arguments of the function select is discussed in the codebook.
 
 In line 57 we only group properly the data .
 
 In line 61 we define a pretty name for a new dataframe and we rename dataframe' columns.
 
 In line 70 we print our fancy dataframe.
