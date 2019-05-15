# coinstarr
Keeping track of quarters

Public budgeting is a difficult task. It gets even harder without access to the right information. Enter `coinstarr`: a way for DC budget analysts to process personnel data and uncover new trends that will lead to smarter spending. Coinstarr is an R package designed to aggregate, transform, analyze, and model agency-level data spread across multiple fiscal quarters. What would normally require hours of coding has been reduced to a suite of functions designed with city officials in mind. Used collectively, these tools can meaningfully track employment vacancies, overtime, and staff leave in just a few lines of R code. Coinstarr is efficient, easy-to-use, and provides DC government with a reliable analytic tool.

## Installation
```
# The development version of this package can be installed from GitHub
devtools::install_github("tjloe/coinstarr")
```

## Objective
Coinstarr uses base R and existing packages to concisely analyze overtime data. It was designed to reduce the amount of code required to generate a full report for several government agencies across fiscal years.


## Data
Three specific types of datasets can be processed using `coinstarr`.
1. The **vacancy** data lists each employment position in the DC government and indicates whether or not that position is filled at several points throughout the year.  For example, the simulated sample data below are included in the package.
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

While actual personnel data cannot be made public, `coinstarr` does include three simulated sample datasets (shown above) that contain randomly generated information and mimic real life values. 

## Features

### Core Functions
Six core functions are used to gather and summarize vacancy, overtime, and leave data. These functions can be run individually, but when run in sequence, they make a powerful combination.
- `collect()` groups observations and generates a tibble with a summary of either *positions* or *hours*, based on the data set.
- `add_fq()`, `add_fy`, and `add_fiscal()` add fiscal quarters or years to a data frame based on an existing date-time variable.
- `join_by()` creates a single data set from two or more data frames (in particular: `jobs`, `overtime`, and `leave`) and joins them by either date or fiscal year.
- `model()` runs a linear regression model with an integrated filter to subset the data

### Helper Functions (Internal)
- `rd()` generates a random draw of `jobs`, `overtime`, or `leave` data

## Getting Started
Let's walk through a typical example of analysis with coinstarr and determine what effect vacancies are having on hours of overtime for agency D based on fiscal quarters.
```
library(coinstarr)
library(magrittr)

# First, we'll collect the data and add fiscal quarters. Let's use a pipe make things easier.
jobs_sum_fq <- add_fiscal(jobs, "payday", start = 10) %>% collect("agency", "fiscal", method = "position")
over_sum_fq <- add_fiscal(overtime, "payday", start = 10) %>% collect("agency", "fiscal", method = "overtime")
leave_sum_fq <- add_fiscal(leave, "payday", start = 10) %>% collect("agency", "fiscal", method = "leave")

# Next, we'll merge our three data frames together
fiscal_data <- join_by(jobs_sum_fq, over_sum_fq, leave_sum_fq, by = c("agency", "fiscal"))

# Here's what it looks like
head(fiscal_data, 3)

## # A tibble: 3 x 9
## # Groups:   vacancies [2]
##  agency fiscal leave.hrs leave.earn vacancies vacancies.prop positions.total overtime.hrs
##  <fct>  <chr>      <dbl>      <dbl>     <int>          <dbl>           <int>        <dbl>
## 1 a      FY201~     15463      73295        19          0.275              69        14409
## 2 a      FY201~      9012      50615        19          0.288              66        10894
## 3 a      FY201~     11207      72105        27          0.375              72        13200
## # ... with 1 more variable: overtime.earn <dbl>

# Now we can model our variables of interest
model(fiscal_data, overtime.hrs ~ vacancies, sift = ("agency == 'd'"))

## Call:
## lm(formula = formula, data = df2)
##
## Coefficients:
## (Intercept)    vacancies  
##     9975.5        136.4  

```

From this example, you can begin to see how the functions in coinstarr work together. Keep reading for an in-depth guide of how to perform this kind of analysis. 

## Usage
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

### Aggregate data with `collect()`
Coinstarr comes with some pretty unhelpful datasets, exactly like the kind you would get when starting a new project. To aggregate the data into more usable data frame, we can use `collect()`.

```
jobs_sum <- collect("jobs", by = "agency", method = "position")
over_sum <- collect("overtime", by = "agency", method = "hours")
leave_sum <- collect("leave", by = "agency", method = "hours")

head(jobs_sum)

## # A tibble: 6 x 5
##  agency payday     vacancies vacancies.prop positions.total
##  <fct>  <date>         <int>          <dbl>           <int>
## 1 a      2011-10-08         2          0.2                10
## 2 a      2011-10-22         5          0.417              12
## 3 a      2011-11-05         2          0.333               6
## 4 a      2011-11-19         4          0.235              17
## 5 a      2011-12-03         2          0.182              11
## 6 a      2011-12-17         2          0.286               7

head(over_sum)

## # A tibble: 6 x 4
##   agency payday     hours.hrs hours.earn
##   <fct>  <date>         <dbl>      <dbl>
## 1 a      2011-10-08       551       3570
## 2 a      2011-10-22      2193       5545
## 3 a      2011-11-05      3300      16175
## 4 a      2011-11-19      2975      13640
## 5 a      2011-12-03      3176      21900
## 6 a      2011-12-17       918       9815

head(leave_sum)

## # A tibble: 6 x 4
##  agency payday     hours.hrs hours.earn
##   <fct>  <date>         <dbl>      <dbl>
## 1 a      2011-10-08      4327      13230
## 2 a      2011-10-22      3187       7600
## 3 a      2011-11-05      1572      10810
## 4 a      2011-11-19      1255       3355
## 5 a      2011-12-03      2692      14210
## 6 a      2011-12-17      1401      16230

# Hint: We can also group by other variables to learn new information about the data. 
# Here's how many vacancies are being caused based on the position description:

vacant_jobs <- collect(jobs, group = "agency", by = "description", method = "position")

head(vacant_jobs)

## # A tibble: 6 x 5
##   agency description        vacancies vacancies.prop positions.total
##  <fct>  <fct>                  <int>          <dbl>           <int>
## 1 a      Assistant Director        63          0.285             221
## 2 a      Data Scientist            71          0.360             197
## 3 a      Director                  72          0.324             222
## 4 a      Fellow                    65          0.286             227
## 5 a      Intern                    55          0.272             202
## 6 a      Operations Analyst        72          0.330             218
```

### Assign fiscal dates with `add_fq()`, `add_fy`, and `add_fiscal()`
Sometimes we'll want to sort the data by fiscal quarter instead of traditional dates. Coinstarr includes three simple functions that will create a new column in your data frame based on another date class variable. 

```
add_fq(jobs, "payday")

##  row     payday position agency      description status is.vacant is.valid   fy
## 1   1 2015-08-08   395008      d  Project Manager      A    VACANT    VALID 2015
## 2   2 2018-09-01   825351      c  Project Manager      F    FILLED  INVALID 2018
## 3   3 2014-04-19   858618      c Social Scientist      P    FILLED    VALID 2014
## 4   4 2012-01-28    95267      d  Project Manager      A    FILLED    VALID 2012
## 5   5 2013-06-15   859643      c           Fellow      V    VACANT    VALID 2013
## 6   6 2017-05-27   843875      c  Project Manager      A    FILLED    VALID 2017

# Hint: coinstarr works with pipes too!
library(magrittr)

add_fiscal(jobs, "payday", start = 10) %>% collect("agency", "fiscal", method = "position")

## # A tibble: 140 x 5
## # Groups:   get(group) [?]
##   agency fiscal   vacancies vacancies.prop positions.total
##   <fct>  <chr>        <int>          <dbl>           <int>
## 1 a      FY2012Q1        19          0.275              69
## 2 a      FY2012Q2        19          0.288              66
## 3 a      FY2012Q3        27          0.375              72
## 4 a      FY2012Q4        16          0.296              54
## 5 a      FY2013Q1        28          0.373              75
## 6 a      FY2013Q2        19          0.264              72
```

### Merge data frames with `join_by()`
After collecting the data, we still need to merge the data sets together so that we can work with several variables at once. This could be done in base R using `merge()`, but coinstarr includes its own function capable of joining three data frames together. It comes with the default arguments to join by `payday` and `agency`.

```
pay_data <- join_by(jobs_sum, over_sum, leave_sum)

head(pay_data)

## # A tibble: 6 x 9
## # Groups:   vacancies [3]
##   agency payday     leave.hrs leave.earn vacancies vacancies.prop positions.total overtime.hrs
##   <fct>  <date>         <dbl>      <dbl>     <int>          <dbl>           <int>        <dbl>
## 1 a      2011-10-08      4327      13230         2          0.2                10          551
## 2 a      2011-10-22      3187       7600         5          0.417              12         2193
## 3 a      2011-11-05      1572      10810         2          0.333               6         3300
## 4 a      2011-11-19      1255       3355         4          0.235              17         2975
## 5 a      2011-12-03      2692      14210         2          0.182              11         3176
## 6 a      2011-12-17      1401      16230         2          0.286               7          918
## # ... with 1 more variable: overtime.earn <dbl>

fiscal_data <- join_by(jobs_sum_fq, over_sum_fq, leave_sum_fq, by = c("agency", "fiscal"))

head(fiscal_data)

## # A tibble: 6 x 9
## # Groups:   vacancies [4]
##   agency fiscal leave.hrs leave.earn vacancies vacancies.prop positions.total overtime.hrs
##   <fct>  <chr>      <dbl>      <dbl>     <int>          <dbl>           <int>        <dbl>
## 1 a      FY201~     15463      73295        19          0.275              69        14409
## 2 a      FY201~      9012      50615        19          0.288              66        10894
## 3 a      FY201~     11207      72105        27          0.375              72        13200
## 4 a      FY201~     12617      58095        16          0.296              54         8718
## 5 a      FY201~     12484      64690        28          0.373              75        13777
## 6 a      FY201~     10741      65090        19          0.264              72        11981
## # ... with 1 more variable: overtime.earn <dbl>
```

### Uncover trends with `model()`
Now that all of the data is organized correctly, we can use `model()` to observe trends that we couldn't see before.

```
model(pay_data, overtime.hrs ~ vacancies, sift = "agency == 'c'")

Call:
lm(formula = formula, data = df2)

Coefficients:
(Intercept)    vacancies  
    1997.73       -26.64  
```

## In Development
Future updates may include integration with other packages like `ggplot2` for graphs and `tinytex` for standardized reporting.

## Note from the Author
This package was prepared for Intro to Programming for Applied Political Data Science, GOVT-696-002, taught by Ryan T. Moore in the School of Public Affairs at American University.

Have questions or suggestions on how to improve this package? Connect me with on [LinkedIn](https://www.linkedin.com/in/tylerjloewenstein/)
