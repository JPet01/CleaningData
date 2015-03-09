Jiri Petr: jiri.petr00@gmail.com

Assignment - Getting and Cleaning data

-------------------------------------------------------CODE BOOK----------------------------------------------------------------

Hi there,

The code of this assignment is separated into 4 parts.

Four different packages are necessary to run the code: plyr, dplyr, tidyr, reshape2

First part of the code is about reading the data. UCI HAR Dataset must be present in working directory 
to run the code smoothly. Check README for further reference of input data.

After reading information about variables (feat), and testing subjects (sutest, subtrain), the main files are read 
by function read.table. 

testlab - activities for test sample

Test sample has been write into "test variable". Mean and Std measures are filtered by using grepl function.
This is step 2 in assignment. Then, info about activities and subject are merged with test data.

Same procedure is done with train sample. After that, both samples are merged using cbind function. This is step 1
in assignment. From this moment, the code follows order of other points in assignment.

During step 3, data are melted into long format and names to activities are mapped with mapvalues function.

Step 4 has been done during previous steps.

Things are getting interesting in step 5.

I choose to use long format. For me, a variable is meant to be each different signal (tBodyAcc-XYZ and so on).
However, lot of different information is stored in this variable, so I decided to made more filters based on variabel description
to simplify work and filtering in output file output file. Then, output file looks more clear. The better solution would be storage
of this info in different table, but there is no room for this in this assignment. 

Keep up the good work on Coursera !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


