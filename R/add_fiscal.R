#' add_fiscal
#'
#' Add fiscal years and fiscal quarters in a single column to a data frame
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

add_fiscal <- function(df, x, start = 10){
  fy <- add_fy(df, x, start)$fy
  fq <- add_fq(df, x, start)$fq
  new <- paste0("FY", fy, "Q", fq)
  df[["fiscal"]] <- new
  return(df)
}
