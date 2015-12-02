
#' Breadth-first search of a graph
#'
#' @param graph Input graph.
#' @param from Character vector, which vertices to start the search
#'   from. By default all vertices are attempted.
#' @return Character vector of the named of the visited vertices,
#'   in the order of their visit.
#'
#' @export

bfs <- function(graph, from = vertices(graph)) {

  graph <- as_graph_adjlist(graph)

  V <- names(graph)
  N <- length(V)
  result <- character()
  q <- character()
  marks <- structure(rep(FALSE, N), names = V)

  while (length(from)) {

    s <- from[1]
    from <- from[-1]
    if (!marks[[s]]) {
      result <- c(result, s)
      marks[[s]] <- TRUE
      q <- c(q, s)
    }

    while (length(q)) {

      s2 <- q[1]
      q <- q[-1]

      for (n in graph[[s2]]) {
        if (!marks[[n]]) {
          result <- c(result, n)
          q <- c(q, n)
          marks[[n]] <- TRUE
        }
      }
    }
  }

  result
}
