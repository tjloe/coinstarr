# coinstarr
Keeping track of quarters

Coinstarr is a convenient tool for analyzing and reporting personell data over several fiscal quarters. Designed for budget analysts in the District of Columbia government, this R package can aggregate agency-level data and summarize deparment vacancies, staff overtime, and hours spent on leave. Future development of coinstarr may also lead to more generic applications. 

## Installation
```
# The development version of this package can be installed from GitHub
devtools::install_github(tjloe/coinstarr)
```

## Objective
Coinstarr makes the best use of base R and existing packages to concisely analyze overtime data. It was designed to reduce the amount of code required to generate a full report for several government agencies across fiscal years.

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
- `merge()` creates a single data set from two or more data frames (in particular: `jobs`, `overtime`, and `leave`) and joins them by either pay period or fiscal year.
- `add_fq()` and `add_fy` add fiscal quarters or years to a data frame based on an existing date-time variable.
- `model()` runs a linear model with user-friendly arguments to specify the variable of interest and which agency to analyze.

### Supplemental Tools (In Development)
- `model_rpt()` produces a linear model of class `rpt` that will produce a LaTeX output when printed.
- `plot_agency()` is a useful graphing function that uses ggplot2 to produce all relevant plots for a given agency.

### Helper Functions (Internal)
- `rd()` generates a random draw of `jobs`, `overtime`, or `leave` data

## Note from the Author
This package was prepared for Intro to Programming for Applied Political Data Science, GOVT-696-001, taught by Ryan T. Moore in the School of Public Affairs at American University.
