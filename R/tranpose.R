
#' Transpose a graph
#'
#' The transposed graph have the same vertices, and the same number
#' of edges, but all edge directions are opposite comparated to the
#' original graph.
#'
#' @param graph Input graph
#' @return Transposed graph.
#'
#' @export

transpose <- function(graph)
  UseMethod("transpose")

#' @method transpose simplegraph_df

transpose.simplegraph_df <- function(graph) {
  new_graph <- graph
  new_graph$edges[[1]] <- graph$edges[[2]]
  new_graph$edges[[2]] <- graph$edges[[1]]
  new_graph
}

#' @method transpose simplegraph_adjlist

transpose.simplegraph_adjlist <- function(graph) {
  res <- structure(
    replicate(length(graph), character()),
    names = names(graph)
  )

  for (v in names(graph)) {
    for (w in graph[[v]]) {
      res[[w]] <- c(res[[w]], v)
    }
  }

  graph(res)
}
