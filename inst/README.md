


# simplegraph

> Simple Graph Data Types and Basic Algorithms

[![Linux Build Status](https://travis-ci.org/MangoTheCat/simplegraph.svg?branch=master)](https://travis-ci.org/MangoTheCat/simplegraph)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/MangoTheCat/simplegraph?svg=true)](https://ci.appveyor.com/project/gaborcsardi/simplegraph)
[![](http://www.r-pkg.org/badges/version/simplegraph)](http://www.r-pkg.org/pkg/simplegraph)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/simplegraph)](http://www.r-pkg.org/pkg/simplegraph)
[![Coverage Status](https://img.shields.io/codecov/c/github/MangoTheCat/simplegraph/master.svg)](https://codecov.io/github/MangoTheCat/simplegraph?branch=master)

Simple classic graph algorithms for simple graph classes.
Graphs may possess vertex and edge attributes. 'simplegraph' has
no dependencies and it is writting entirely in R, so it is easy to
install.

## Installation


```r
devtools::install_github("mangothecat/simplegraph")
```

## Usage


```r
library(simplegraph)
```

```
#> 
#> Attaching package: 'simplegraph'
#> 
#> The following object is masked from 'package:base':
#> 
#>     order
```

## Creating graphs

`simplegraph` has two ways of creating graphs from data.
The first one is an adjacency list containing vertex names.
This is Euler's famous graph of the bridges of Koenigsberg.
Note that all graphs are directed in `simplegraph`. Undirected graphs
can be emulated with bidirectional edges.


```r
bridges <- graph(list(
  "Altstadt-Loebenicht" = c(
    "Kneiphof",
    "Kneiphof",
    "Lomse"
  ),
  "Kneiphof" = c(
    "Altstadt-Loebenicht",
    "Altstadt-Loebenicht",
    "Vorstadt-Haberberg",
    "Vorstadt-Haberberg",
    "Lomse"
  ),
  "Vorstadt-Haberberg" = c(
    "Kneiphof",
    "Kneiphof",
    "Lomse"
  ),
  "Lomse" = c(
    "Altstadt-Loebenicht",
    "Kneiphof",
    "Vorstadt-Haberberg"
  )
))
bridges
```

```
#> $`Altstadt-Loebenicht`
#> [1] "Kneiphof" "Kneiphof" "Lomse"   
#> 
#> $Kneiphof
#> [1] "Altstadt-Loebenicht" "Altstadt-Loebenicht" "Vorstadt-Haberberg" 
#> [4] "Vorstadt-Haberberg"  "Lomse"              
#> 
#> $`Vorstadt-Haberberg`
#> [1] "Kneiphof" "Kneiphof" "Lomse"   
#> 
#> $Lomse
#> [1] "Altstadt-Loebenicht" "Kneiphof"            "Vorstadt-Haberberg" 
#> 
#> attr(,"class")
#> [1] "simplegraph_adjlist" "simplegraph"         "list"
```

## Graph metadata

`simplegraph` supports graph metadata on vertices and edges.
To create a graph with metadata, pass two data frames to `graph`,
one for vertices, one for edges.

The first column of the vertex data frame must contain the ids of
the vertices in a character vector.

The first columns of the edge data frame must contain the edges of
the graph, i.e. the tail vertices and the head vertices, given
by the vertex ids.

Here is an example for a graph of actors and movies.


```r
vertices <- data.frame(
  stringsAsFactors = FALSE,
  name = c("Tom Hanks", "Cate Blanchett", "Matt Damon", "Kate Winslet",
    "Saving Private Ryan", "Contagion", "The Talented Mr. Ripley"),
  what = c("actor", "actor", "actor", "actor", "movie", "movie", "movie"),
  born = c("1956-07-09", "1966-05-26", "1970-10-08", "1975-10-05",
    NA, NA, NA),
  gender = c("M", "F", "M", "F", NA, NA, NA),
  year = c(NA, NA, NA, NA, 1998, 2011, 1999)
)

edges <- data.frame(
  stringsAsFactors = FALSE,
  actor = c("Tom Hanks", "Cate Blanchett", "Matt Damon", "Matt Damon", 
    "Kate Winslet"),
  movie = c("Saving Private Ryan", "The Talented Mr. Ripley",
    "Saving Private Ryan", "The Talented Mr. Ripley", "Contagion")
)
actors <- graph(vertices, edges)
```


```r
vertex_ids(actors)
```

```
#> [1] "Tom Hanks"               "Cate Blanchett"         
#> [3] "Matt Damon"              "Kate Winslet"           
#> [5] "Saving Private Ryan"     "Contagion"              
#> [7] "The Talented Mr. Ripley"
```

```r
vertices(actors)
```

```
#>                      name  what       born gender year
#> 1               Tom Hanks actor 1956-07-09      M   NA
#> 2          Cate Blanchett actor 1966-05-26      F   NA
#> 3              Matt Damon actor 1970-10-08      M   NA
#> 4            Kate Winslet actor 1975-10-05      F   NA
#> 5     Saving Private Ryan movie       <NA>   <NA> 1998
#> 6               Contagion movie       <NA>   <NA> 2011
#> 7 The Talented Mr. Ripley movie       <NA>   <NA> 1999
```

```r
edges(actors)
```

```
#>            actor                   movie
#> 1      Tom Hanks     Saving Private Ryan
#> 2 Cate Blanchett The Talented Mr. Ripley
#> 3     Matt Damon     Saving Private Ryan
#> 4     Matt Damon The Talented Mr. Ripley
#> 5   Kate Winslet               Contagion
```

## Basic queries

Number of vertices and edges:


```r
order(bridges)
```

```
#> [1] 4
```

```r
size(bridges)
```

```
#> [1] 14
```

Adjacenct vertices:


```r
adjacent_vertices(bridges)$Lomse
```

```
#> [1] "Altstadt-Loebenicht" "Kneiphof"            "Vorstadt-Haberberg" 
#> [4] "Altstadt-Loebenicht" "Kneiphof"            "Vorstadt-Haberberg"
```

This is a graph of function calls from the R package `pkgsnap`
(https://github.com/mangothecat/pkgsnap):


```r
funcs <- graph(list(
  drop_internal = character(0),
  get_deps = c("get_description", "parse_deps",
    "%||%", "drop_internal"),
  get_description = "pkg_from_filename",
  parse_deps = "str_trim",
  cran_file = c("get_pkg_type", "r_minor_version", "cran_file"),
  download_urls = c("split_pkg_names_versions", "cran_file"),
  filename_from_url = character(0),
  get_pkg_type = character(0),
  pkg_download = c("dir_exists", "download_urls",
    "filename_from_url", "try_download"),
  r_minor_version = character(0),
  try_download = character(0),
  drop_missing_deps = character(0),
  install_order = character(0),
  restore = c("pkg_download", "drop_missing_deps",
    "install_order", "get_deps"),
  snap = character(0),
  `%||%` = character(0),
  data_frame = character(0),
  dir_exists = character(0),
  pkg_from_filename = character(0),
  split_pkg_names_versions = "data_frame",
  str_trim = character(0)
))
```

List of vertices:


```r
vertices(funcs)
```

```
#>                        name
#> 1             drop_internal
#> 2                  get_deps
#> 3           get_description
#> 4                parse_deps
#> 5                 cran_file
#> 6             download_urls
#> 7         filename_from_url
#> 8              get_pkg_type
#> 9              pkg_download
#> 10          r_minor_version
#> 11             try_download
#> 12        drop_missing_deps
#> 13            install_order
#> 14                  restore
#> 15                     snap
#> 16                     %||%
#> 17               data_frame
#> 18               dir_exists
#> 19        pkg_from_filename
#> 20 split_pkg_names_versions
#> 21                 str_trim
```

List of edges:


```r
edges(funcs)
```

```
#>                        from                       to
#> 1                  get_deps          get_description
#> 2                  get_deps               parse_deps
#> 3                  get_deps                     %||%
#> 4                  get_deps            drop_internal
#> 5           get_description        pkg_from_filename
#> 6                parse_deps                 str_trim
#> 7                 cran_file             get_pkg_type
#> 8                 cran_file          r_minor_version
#> 9                 cran_file                cran_file
#> 10            download_urls split_pkg_names_versions
#> 11            download_urls                cran_file
#> 12             pkg_download               dir_exists
#> 13             pkg_download            download_urls
#> 14             pkg_download        filename_from_url
#> 15             pkg_download             try_download
#> 16                  restore             pkg_download
#> 17                  restore        drop_missing_deps
#> 18                  restore            install_order
#> 19                  restore                 get_deps
#> 20 split_pkg_names_versions               data_frame
```

## Manipulation

Transposing a graph changes the directions of all edges to
the opposite.


```r
edges(transpose(funcs))
```

```
#>                        from                       to
#> 1             drop_internal                 get_deps
#> 2                  get_deps                  restore
#> 3           get_description                 get_deps
#> 4                parse_deps                 get_deps
#> 5                 cran_file                cran_file
#> 6                 cran_file            download_urls
#> 7             download_urls             pkg_download
#> 8         filename_from_url             pkg_download
#> 9              get_pkg_type                cran_file
#> 10             pkg_download                  restore
#> 11          r_minor_version                cran_file
#> 12             try_download             pkg_download
#> 13        drop_missing_deps                  restore
#> 14            install_order                  restore
#> 15                     %||%                 get_deps
#> 16               data_frame split_pkg_names_versions
#> 17               dir_exists             pkg_download
#> 18        pkg_from_filename          get_description
#> 19 split_pkg_names_versions            download_urls
#> 20                 str_trim               parse_deps
```

## Walks on graphs

Breadth-first search:


```r
bfs(funcs)
```

```
#>  [1] "drop_internal"            "get_deps"                
#>  [3] "get_description"          "parse_deps"              
#>  [5] "%||%"                     "pkg_from_filename"       
#>  [7] "str_trim"                 "cran_file"               
#>  [9] "get_pkg_type"             "r_minor_version"         
#> [11] "download_urls"            "split_pkg_names_versions"
#> [13] "data_frame"               "filename_from_url"       
#> [15] "pkg_download"             "dir_exists"              
#> [17] "try_download"             "drop_missing_deps"       
#> [19] "install_order"            "restore"                 
#> [21] "snap"
```

## Topological sort


```r
topological_sort(simplify(funcs))
```

```
#>  [1] "snap"                     "restore"                 
#>  [3] "install_order"            "drop_missing_deps"       
#>  [5] "pkg_download"             "try_download"            
#>  [7] "dir_exists"               "filename_from_url"       
#>  [9] "download_urls"            "split_pkg_names_versions"
#> [11] "data_frame"               "cran_file"               
#> [13] "r_minor_version"          "get_pkg_type"            
#> [15] "get_deps"                 "%||%"                    
#> [17] "parse_deps"               "str_trim"                
#> [19] "get_description"          "pkg_from_filename"       
#> [21] "drop_internal"
```

## Multi-graphs and graphs with loop edges

Detecting loop and multiple edges:


```r
is_loopy(funcs)
```

```
#> [1] TRUE
```

```r
is_multigraph(funcs)
```

```
#> [1] FALSE
```

Removing loop and multiple edges:


```r
is_loopy(remove_loops(funcs))
```

```
#> [1] FALSE
```

```r
is_multigraph(remove_multiple(funcs))
```

```
#> [1] FALSE
```

`simplify` removes both loops and multiple edges, so it creates
a simple graph:


```r
is_loopy(simplify(funcs))
```

```
#> [1] FALSE
```

```r
is_multigraph(simplify(funcs))
```

```
#> [1] FALSE
```

```r
is_simple(simplify(funcs))
```

```
#> [1] TRUE
```

## License

MIT © [Mango Solutions](https://github.com/mangothecat).
