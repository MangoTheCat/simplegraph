
#' Vertices of a graph
#'
#' @param graph The graph.
#' @return Character vector of vertex names.
#'
#' @export

vertices <- function(graph) {
  graph <- as_graph_adjlist(graph)
  names(graph)
}

#' Edges of a graph
#'
#' @param graph The graph
#' @return Data frame of edge data and metadata. The tail and head
#'   vertices are in the fist two columns. The rest of the columns are
#'   metadata.
#'
#' @export

edges <- function(graph) {
  graph <- as_graph_data_frame(graph)
  graph$edges
}

#' Order of a graph
#'
#' The order of the graph is the number of vertices.
#'
#' @param graph The graph.
#' @return Numeric scalar, the number of vertices.
#'
#' @export

order <- function(graph) {
  graph <- as_graph_adjlist(graph)
  length(graph)
}

#' The size of the graph is the number of edges
#'
#' @param graph The graph.
#' @return Numeric scalar, the number of edges.
#'
#' @export

size <-function(graph) {
  graph <- as_graph_data_frame(graph)
  nrow(graph$edges)
}

#' Adjacent vertices for all vertices in a graph
#'
#' A vertex is adjacent is it is either a successor, or a predecessor.
#'
#' @param graph The graph.
#' @return A named list of character vectors, the adjacent vertices
#'   for each vertex.
#'
#' @export

adjacent_vertices <- function(graph) {
   graph <- as_graph_adjlist(graph)
   merge_named_lists(graph, transpose(graph))
}
