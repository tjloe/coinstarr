#' model
#'
#' Generates a linear model for the variables of interest and given filter.
#'
#' A useful adaption to \code{lm()} with an integrated filter
#'
#' @author Tyler J. Loewenstein
#'
#' @param df A data frame
#' @param formula An object of class "formula"
#' @param sift A logical test to filter observations in the data frame
#'
#' @export

model <- function(df, formula, sift = NULL) {
  if (!class(formula) == "formula") {
    stop("formula argument is not valid.")
  }

  if (is.null(sift)) {
    out <- lm(formula, data = df)
  } else {
    df2 <- subset(df, eval(parse(text = sift)))
    out <- lm(formula, data = df2)

  }
  return(out)
}




