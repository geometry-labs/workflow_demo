test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("R version of nestedLoops gives correct result", {
  expect_equal(
    nestedLoops(nestedLoopsValidationX, nestedLoopsValidationY),
    nestedLoopsValidationResult
  )
})

test_that("Rcpp version of nestedLoops gives correct result", {
  expect_equal(
    nestedLoopsRcpp(nestedLoopsValidationX, nestedLoopsValidationY),
    nestedLoopsValidationResult
  )
})

test_that("cpp11 version of nestedLoops gives correct result", {
  expect_equal(
    nestedLoopsCpp11(nestedLoopsValidationX, nestedLoopsValidationY),
    nestedLoopsValidationResult
  )
})

test_that("Rcpp parallelized version of nestedLoops gives correct result", {
  expect_equal(
    nestedLoopsRcppParallelized(nestedLoopsValidationX, nestedLoopsValidationY),
    nestedLoopsValidationResult
  )
})
