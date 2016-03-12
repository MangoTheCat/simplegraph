
#' Check if object is a simplegraph
#'
#' This is currently used for internal assertions 
#'
#' @param x An R object.
#' @return TRUE if \code{x} is a \code{simplegraph} object. \code{FALSE}
#'   otherwise.
#' @keywords internal
#' @importFrom methods is

is_simplegraph <- function(x) {
  is(x, "simplegraph")
}

#' Check if the an object is a sequence of vertices from a graph
#'
#' @param v R object.
#' @param g Graph.
#' @return \code{TRUE} if \code{v} are vertices from \code{g}.
#' @keywords internal

is_vertices_of <- function(v, g) {
  stopifnot(is.character(v))
  all(v %in% vertex_ids(g))
}
