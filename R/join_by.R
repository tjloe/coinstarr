#' join_by
#'
#' Creates a single data frame by combining \code{jobs}, \code{overtime},
#' and \code{leave} according to the `by` argument.
#'
#' @author Tyler J. Loewenstein
#'
#' @param dfx A data frame (likely `jobs`).
#' @param dfy A data frame (likely `overtime`).
#' @param dfz A data frame (likely `leave`).
#' @param by One or more grouping variables, typically `agency` and `payday`.
#'
#' @export

join_by <- function(dfx, dfy, dfz, by = c("agency", "payday")){

  `%>%` <- magrittr::`%>%`

  dplyr::full_join(x = dfx, y = dfy, by = by) %>%
    dplyr::full_join(x = dfz, by = by)

}
