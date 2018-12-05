#' add_fq
#'
#' Add fiscal quarters to a data frame
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

add_fq <- function(df, x, start = 10){

  if(!is.null(df[["fq"]])){
    stop("Column 'fq' already exists!")
  }

  df2 <- df

  df2[["fq"]] <- lubridate::quarter(df2[[x]], fiscal_start = start)

  return(df2)

}
