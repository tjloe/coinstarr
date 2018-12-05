#' rd
#'
#' Takes a random draw of sample data for testing coinstarr
#'
#' @author Tyler J. Loewenstein
#'
#' @keywords internal

rd <- function(n, type){

# setup
paydays <- seq(as.Date("2011/10/08"), as.Date("2018/09/01"), by = "2 weeks")
positions <- c("Director", "Assistant Director", "Project Manager", "Data Scientist",
          "Social Scientist", "Operations Analyst", "Fellow", "Research Assistant",
          "Intern")
status <- c("A", "F", "P", "R", "V")
vacantFilled <- c("VACANT", "FILLED")
validInvalid <- c("VALID", "INVALID")

if(type == "jobs"){

    out <- data.frame(row = 1:n,
                  payday = sample(paydays, n, replace = TRUE),
                  position = round(runif(n, 1, 10^6)),
                  agency = sample(letters[1:5], n, replace = TRUE),
                  description = sample(positions, n, replace = TRUE),
                  status = sample(status, n, replace = TRUE),
                  is.vacant = sample(vacantFilled, n, replace = TRUE, prob = c(.30, .70)),
                  is.valid = sample(validInvalid, n, replace = TRUE, prob = c(.98, .2))
    )
  } else if(type == "overtime"){

    out <- data.frame(row = 1:n,
                           company = sample(letters[1:5], n, replace = TRUE),
                           paygroup = sample(letters[6:10], n, replace = TRUE),
                           payday = sample(paydays, n, replace = TRUE),
                           paynum = round(runif(n, 1, 10^6)),
                           agency = sample(letters[1:5], n, replace = TRUE),
                           name = randomNames(n),
                           type = sample(letters[1:10], n, replace = TRUE),
                           hours = round(rnorm(n, sd = 13)^2),
                           earnings = 5*(round(rnorm(n, sd = 13)^2))
    )
  } else if(type == "leave"){

    out <- data.frame(row = 1:n,
                           company = sample(letters[1:5], n, replace = TRUE),
                           paygroup = sample(letters[6:10], n, replace = TRUE),
                           payday = sample(paydays, n, replace = TRUE),
                           paynum = round(runif(n, 1, 10^6)),
                           agency = sample(letters[1:5], n, replace = TRUE),
                           name = randomNames::randomNames(n),
                           type = sample(letters[1:10], n, replace = TRUE),
                           hours = round(rnorm(n, sd = 13)^2),
                           earnings = 5*(round(rnorm(n, sd = 13)^2))
    )
  }

return(out)

}
