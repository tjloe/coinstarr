#' collect
#'
#' Summarizes raw agency data into vacancies, overtime hours, and leave hours
#'
#' This is where the details will go.
#'
#' @author Tyler J. Loewenstein
#'
#' @param df a data frame
#' @param group1 a grouping variable
#' @param group2 a second grouping variable different from group1
#' @param method a method
#'
#' @export

collect <- function(df, group1, group2, method = "position"){

  `%>%` <- magrittr::`%>%`

  if(!method %in% c("position", "overtime", "leave")){
    stop("unknown method")
  }

  df %>%
    dplyr::group_by(get(group1), get(group2)) %>%
    dplyr::summarize(vacancies = sum(is.vacant == "VACANT"),
              vacancies.prop = vacancies / sum(n()),
              positions.total = sum(is.vacant != ""))
}
