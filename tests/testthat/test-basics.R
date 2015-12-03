
context("Basics")

test_that("vertices", {

  g1 <- g1()
  g2 <- g2()
  g3 <- g3()

  expect_equal(vertices(g1), letters[1:5])
  expect_equal(vertices(g2), letters[1:5])
  expect_equal(vertices(g3), character())
})

test_that("edges", {

  g1 <- g1()
  g2 <- g2()
  g3 <- g3()

  expect_equal(edges(g1), g1$edges)
  expect_equal(edges(g2), g2$edges)
  expect_equal(edges(g3), g3$edges)
})

test_that("order and size", {

  g1 <- g1()
  g2 <- g2()
  g3 <- g3()

  expect_equal(order(g1), 5)
  expect_equal(order(g2), 5)
  expect_equal(order(g3), 0)

  expect_equal(size(g1), 6)
  expect_equal(size(g2), 0)
  expect_equal(size(g3), 0)
})

test_that("adjacent vertices", {
  g1 <- g1()
  g2 <- g2()
  g3 <- g3()

  expect_equal(
    adjacent_vertices(g1),
    list(
      a = c("b", "e", "b", "e"),
      b = c("a", "d", "a"),
      c = c("c", "c"),
      d = c("b"),
      e = c("a", "a")
    )
  )

  expect_equal(
    adjacent_vertices(g2),
    list(
      a = character(), b = character(), c = character(),
      d = character(), e = character()
    )
  )

  expect_equal(
    adjacent_vertices(g3),
    structure(list(), names = character())
  )
})

test_that("predecessors and successors", {

  G <- graph(list(A = c("B", "C"), B = "C", C = "A"))

  expect_equal(
    predecessors(G),
    list(A = c("C"), B = "A", C = c("A", "B"))
  )

  expect_equal(
    successors(G),
    list(A = c("B", "C"), B = "C", C = "A")
  )

})
