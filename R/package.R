
#' Simple Graph Data Types and Basic Algorithms
#'
#' Simple classic graph algorithms for simple graph classes.
#' Graphs may possess vertex and edge attributes. 'simplegraph' has
#' to dependencies and it is writting entirely in R, so it is easy to
#' install.
#'
#' @docType package
#' @name simplegraph
NULL

#' Create a graph
#'
#' Graphs can be specified as adjacency lists or (two) data frames.
#'
#' If the first argument is a data frame, then it is interpreted as
#' vertex data, and a second data frame must be supplied as edge data.
#' The first column of the vertex data must contain (character) vertex
#' ids. The first two columns of the edge data frame must contain the
#' directed edges of the graph, in the order of tail and head, as
#' characters referring to the nodes ids. Other columns are kept as
#' metadata.
#'
#' If the first argument is not a data frame, but a list, then it is
#' interpreted as an adjacency list. It must be named, and the names
#' will be used as vertex ids. Each list element must be a character
#' vector containing the successors of each vertex.
#'
#' @param x A data frame, or a named list of character vectors. See
#'   details below.
#' @param ... Additional arguments, see details below.
#' @return A graph object.
#'

#' @export

graph <- function(x, ...)
  UseMethod("graph")

#' Check the validity of a graph data structure
#'
#' This is mainly for internal checks, but occasionally it
#' might also useful externally.
#'
#' @param x Graph.
#' @param ... Extra arguments are curently ignored.
#'
#' @export

sanitize <- function(x, ...)
  UseMethod("sanitize")
