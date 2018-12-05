#' model
#'
#' Generates a linear model for the variables of interest and given agency
#'
#' A useful adaption to \code{lm()} with an agency filter.
#'
#' @author Tyler J. Loewenstein
#'
#' @param df A data frame
#' @param formula An object of class "formula"
#' @param agency If `NULL`, all agencies are included in the regression. If set
#' to "each", a model for each agency will be produced. Otherwise, argument may
#' be set to filter a specific agency.
#'
#' @export

model <- function(df, formula, agency = NULL){

  if(!class(formula) == "formula"){
    stop("formula argument is not valid.")
  }

  if(is.null(agency)){
    out <- lm(formula = formula, data = df)
    return(out)
  } else if(agency == "each"){

    for(i in unique(df[["agency"]])){
      df2 <- dplyr::filter(df, agency == i)
      out <- lm(formula, data = df2)
      return(out)
    }
    } else {

      df2 <- dplyr::filter(df, agency == agency)
      out <- lm(formula, data = df2)
      return(out)
    }

  }




