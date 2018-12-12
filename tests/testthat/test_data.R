library(coinstarr)
context("data")

test_that("data is correct dimensions", {
  expect_equal(nrow(jobs), 10000)

})
