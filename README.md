dme.churn
=========

Data Mining and Exploration: Customer Churn Project

reports/ - will be where we will work on the interim report and final report
data/ 	 - i've downloaded the small dataset for the project from the [here] (http://www.sigkdd.org/kddcup/index.php?section=2009&method=data).

R
===
NOTE: i'll try to see if we can do this in R, and update it in this tread here


Data Format
===========

The datasets use a format similar as that of the text export format from relational databases:

* One header lines with the variables names
* One line per instance
* Separator tabulation between the values
* There are missing values (consecutive tabulations)

The large matrix results from appending the various chunks downloaded in their order number. The header line is present only in the first chunk.

The target values (.labels files) have one example per line in the same order as the corresponding data files. Note that churn, appetency, and up-selling are three separate binary classification problems. The target values are +1 or -1. We refer to examples having +1 (resp. -1) target values as positive (resp. negative) examples.

The Matlab matrices are numeric. When loaded, the data matrix is called X. The categorical variables are mapped to integers. Missing values are replaced by NaN for the original numeric variables while they are mapped to 0 for categorical variables.


Notes about the data format
===========================

The data format is absolutely dreadfull. First thing we need to do is clean it and make it into a standardised format that we can play with in other applications. At this point in time it is extremely raw and unusable. 

With regards to conversion i have come accross the following matlab scripts which import it into the system. Not if we decided on using R instead we can conver them into R.

[Here](http://jmlr.csail.mit.edu/proceedings/papers/v7/supplemental/JMLRWCP_V7_supplemental.html) you can find the scripts as well as additional information about the dataset.