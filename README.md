# FutureLearn

This README will cover the contents of the project directory, as well as how to knit the report.
```
FutureLearn
├──cache       # contains the cached version of the data, as well as munged data.
├──config
├──data        # the raw CSV data files
├──diagnostics
├──docs
├──graphs      # PNG files of the graphs used. writen over when knitted.
├──lib
├──logs
├──munge
│ ├──01_A.R    # creates data frame of learners with enrolment data,
│ ├── 02_A.R    # appends engagement data to previous data frame.
│ ├── 01_B.R    # creates data frame of countries and total count of learners
│ ├── 02_B.R    # appends completion count and percentage to previous data frame
│ └──  02-C.R    # appends engagement count and percentage to previous data frame
├──profiling
├──reports
│ ├── Analysis_Report.Rmd    # the Rmarkdown that generates the repport.
│ └──  Analysis_Report.pdf    # the report
├──src         # Contains the R files that generates the graphs and save them to /graphs.
├──tests
```

To load the project, you'll first need to `setwd()` into the directory
where this README file is located. Then you need to run the following two
lines of R code:

	library('ProjectTemplate')
	load.project()

After you enter the second line of code, you'll see a series of automated
messages as ProjectTemplate goes about doing its work. This work involves:
* Reading in the global configuration file contained in `config`.
* Loading any R packages you listed in the configuration file.
* Reading in any datasets stored in `data` or `cache`.
* Preprocessing your data using the files in the `munge` directory.

Once that's done, you can execute any code you'd like.

You'll have access to all of your data, already fully preprocessed, and
all of the libraries you want to use.
