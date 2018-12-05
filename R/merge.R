#' merge
#'
#' Merges creates a single data frame by combining \code{jobs}, \code{overtime},
#' and \code{leave}.
#'
#' @author Tyler J. Loewenstein
#'
#' @param dfx A data frame (likely `jobs`).
#' @param dfy A data frame (likely `overtime`).
#' @param dfz A data frame (likely `leave`).
#'
#' @export

merge <- function(dfx, dfy, dfz){

  `%>%` <- magrittr::`%>%`

  dplyr::full_join(x = dfx, y = dfy, by = c("agency", "payday")) %>%
    dplyr::full_join(x = dfz, by = c("agency", "payday"))

}
