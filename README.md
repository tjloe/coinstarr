# coinstarr
Keeping track of quarters

Public budgeting is a difficult task. It gets even harder without access to the right information. Enter coinstarr: a way for DC budget analysts to process personell data and uncover new trends that will lead to smarter spending. Coinstarr is an R package designed to aggregate, transform, analyze, and model agency-level data spread across multiple fiscal quarters. What would normally require hours of coding has been reduced to a suite of functions designed with city officials in mind. Used collectively, these tools can meaninfully track employment vacancies, overtime, and staff leave in as little as six lines of code. Coinstarr is efficient, easy-to-use, and provides DC government with a reliable analytic tool.

## Installation
```
# The development version of this package can be installed from GitHub
devtools::install_github("tjloe/coinstarr")

# You may need to specify a personal access token
devtools::install_github("tjloe/coinstarr", auth_token = "3544235425gyjhfg435245gv23"
```

## Objective
Coinstarr makes the best use of base R and existing packages to concisely analyze overtime data. It was designed to reduce the amount of code required to generate a full report for several government agencies across fiscal years.


## Data
Three specific types of datasets can be procesessed using coinstarr.
1. The **vacancy** data lists each employment position in the DC government and indicates whether or not that position is filled at several points throughout the year.
``` 
head(jobs, 3)

##  row payday position agency      description status is.vacant is.valid
##  1   1 2015-08-08   395008      d  Project Manager      A    VACANT    VALID
##  2   2 2018-09-01   825351      c  Project Manager      F    FILLED  INVALID
##  3   3 2014-04-19   858618      c Social Scientist      P    FILLED    VALID
```
2. The **overtime** data lists entires for employee overtime along with the earnings that employee acquired.
```
head(overtime, 3)

##  row company paygroup     payday paynum agency              name type hours earnings
##  1   1       e        f 2014-02-08 896048      a Waters, Nathaniel    a    65        0
##  2   2       b        g 2016-04-02 194383      c      Neal, Hannah    h    57      185
##  3   3       c        h 2014-11-15 843271      d    Gabriel, Haley    d     2      405
```

3. The **leave** data lists entires for employees who took leave along with any earnings that employee accrued while on leave.
```
head(leave, 3)

##  row company paygroup     payday paynum agency                   name type hours earnings
## 1   1       c        i 2012-07-28  31999      c Akimoto-Miller, Jeanne    i     8      965
## 2   2       c        h 2017-09-02 348603      e            Nava, Tyler    c   236     1065
## 3   3       c        g 2012-10-20 586200      a    al-Waheed, Rasheeda    a     5     1365
```

While actual personell data cannot be made public, coinstarr does include three dummy datasets that contain randomly generated information and mimic real life values. 

## Features

### Core Functions
Five core functions are used to gather and summarize vacancy, overtime, and leave data.
- `collect()` groups observations and generates a tibble with a summary of either *positions* or *hours*, based on the data set.
- `join_by()` creates a single data set from two or more data frames (in particular: `jobs`, `overtime`, and `leave`) and joins them by either pay period or fiscal year.
- `add_fq()` and `add_fy` add fiscal quarters or years to a data frame based on an existing date-time variable.
- `model()` runs a linear model with user-friendly arguments to specify the variable of interest and which agency to analyze.

### Supplemental Tools (In Development)
- `model_rpt()` produces a linear model of class `rpt` that will produce a LaTeX output when printed.
- `plot_agency()` is a useful graphing function that uses ggplot2 to produce all relevant plots for a given agency.

### Helper Functions (Internal)
- `rd()` generates a random draw of `jobs`, `overtime`, or `leave` data

## Getting Started
Let's walk through a typical analysis example and determine what effect vacancies are having on hours of overtime for agency C.
```
library(coinstarr)

data(jobs)
data(overtime)
data(leave)

# Hint: If you want to use your own random draw of dummy data, try:
library(randomNames)

coinstarr:::rd(n = 100, "jobs")
coinstarr:::rd(n = 100, "overtime")
coinstarr:::rd(n = 100, "leave")
```

### Aggregating with `collect()'
Coinstarr comes with some pretty unhelpful datasets, exactly like the kind you would load in an Excel report for DC government. To aggregate the data into more usable data frame, we can use `collect()`.

```
jobs_sum <- collect("jobs", group = "payday", method = "position")
head(job
```

## Note from the Author
This package was prepared for Intro to Programming for Applied Political Data Science, GOVT-696-001, taught by Ryan T. Moore in the School of Public Affairs at American University.
