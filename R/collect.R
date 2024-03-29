#' collect
#'
#' Summarizes raw agency data into vacancies, overtime hours, and leave hours
#'
#' collect will accept any of the three data sets that come loaded with coinstarr.
#'
#' @author Tyler J. Loewenstein
#'
#' @param df a data frame
#' @param group a grouping variable
#' @param by a second grouping variable different from \code{group}
#' @param method a method specifying what type of data is being used. Can be either "position", "overtime", or "leave".
#'
#'
#' @examples
#' collect(jobs, "agency", method = "position")
#' collect(overtime, "paygroup", method = "overtime")
#' collect(leave, "type", method = "leave")
#'
#' @export

collect <- function(df, group, by = "payday", method) {
  `%>%` <- magrittr::`%>%`

  if (!method %in% c("position", "overtime", "leave")) {
    stop("unknown method")
  }

  if (method == "position") {
    new <- df %>%
      dplyr::group_by(get(group), get(by)) %>%
      dplyr::summarize(
        vacancies = sum(is.vacant == "VACANT"),
        vacancies.prop = vacancies / sum(n()),
        positions.total = sum(is.vacant != "")
      )

  } else {
    name.hrs <- paste(method, "hrs", sep = ".")
    name.earn <- paste(method, "earn", sep = ".")

    new <- df %>%
      dplyr::group_by(get(group), get(by)) %>%
      dplyr::summarize(!!name.hrs := sum(hours),
                       !!name.earn := sum(earnings))
  }

  colnames(new)[1] <- group
  colnames(new)[2] <- by

  return(new)
}
