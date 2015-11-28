
merge_named_lists <- function(list1, list2, default = character()) {

  names <- unique(sort(c(names(list1), names(list2))))

  res <- lapply(names, function(n) { c(list1[[n]], list2[[n]]) %||% default })

  names(res) <- names
  res
}

`%||%` <- function(l, r) if (is.null(l)) r else l
