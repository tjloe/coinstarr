#' coins
#'
#' Prints the word "coin" a number of times equal to \code{x}
#'
#' \code{coins} is a test function.
#'
#' @author Tyler J. Loewenstein
#'
#' @param x A double.
#'
#' @return The word "coin" repeated \code{x} times.
#'
#' @example
#' coins(5)
#'
#' @export

coins <- function(x){
  for(i in 1:x){
    print("coin")
  }
  out <- paste(x, "coins were printed.")
  print(out)
}
