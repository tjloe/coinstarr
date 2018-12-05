#' add_fy
#'
#' Add fiscal years to a data frame
#'
#' Creates a new column based on an existing vector of class date-time.
#'
#' @author Tyler J. Loewenstein
#'
#' @param df A data frame
#' @param x A date-time variable in \code{df}
#' @param start numeric indicating the starting month of a fiscal year
#'
#' @export

add_fy <- function(df, x, start = 10){

  if(!is.null(df[["fy"]])){
    stop("Column 'fy' already exists!")
  }

  df2 <- df

  df2[["fy"]] <- lubridate::year(df[[x]]) + (month(df[[x]]) >= start)

  return(df2)

}
