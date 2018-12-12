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
#' @param filter A logical test to filter observations in the data frame
#'
#' @export

model <- function(df, formula, filter = NULL){

  if(!class(formula) == "formula"){
    stop("formula argument is not valid.")
  }

  if(is.null(filter)){
    out <- lm(formula, data = df)
  } else {

    out <- lm(formula, data = dplyr::filter(df, filter))

  }


}




