

#' Title
#'
#' @param x description
#' @param y description
#'
#' @return description
#' @export
#'
#' @examples
#' 1
nestedLoops <- function(x, y) {

  stopifnot(nrow(x) == ncol(x))

  stopifnot(all(dim(x) == dim(y)))

  stopifnot(is.integer(y))

  z <- matrix(0, nrow(x), ncol(x))

  for (i in seq_len(nrow(x))) {
    for (j in seq_len(ncol(x))) {
      z[i, j] <- sqrt(abs(
        x[y[i, j], y[j, i]] * x[y[j, i], y[i, j]]
      ))
    }
  }

  return(z)

}


#' Title
#'
#' @param x description
#' @param y description
#'
#' @return description
#' @export
#'
#' @examples
#' 1
nestedLoopsRcpp <- function(x, y) {

  stopifnot(nrow(x) == ncol(x))

  stopifnot(all(dim(x) == dim(y)))

  stopifnot(is.integer(y))

  # z <- .Call(`_RcppTest3_rcpp_nested_loops`)
  z <- rcpp_nested_loops(x, y)

  return(z)

}



#' Title
#'
#' @param x description
#' @param y description
#'
#' @return description
#' @export
#'
#' @examples
#' 1
nestedLoopsCpp11 <- function(x, y) {

  stopifnot(nrow(x) == ncol(x))

  stopifnot(all(dim(x) == dim(y)))

  stopifnot(is.integer(y))

  z <- cpp11_nested_loops(x, y)

  return(z)

}



#' Title
#'
#' @param x description
#' @param y description
#'
#' @return description
#' @export
#'
#' @examples
#' 1
nestedLoopsRcppParallelized <- function(x, y) {

  stopifnot(nrow(x) == ncol(x))

  stopifnot(all(dim(x) == dim(y)))

  stopifnot(is.integer(y))

  z <- rcpp_parallel_nested_loops(x, y)

  return(z)

}

