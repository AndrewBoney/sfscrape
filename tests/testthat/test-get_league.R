leagues <- get_leagues(220006)

test_that("colnames", {
  expect_equal(colnames(leagues), c("codes", "league"))
})

test_that("types", {
  expect_equal(class(leagues), "data.frame")
  expect_equal(class(leagues$codes), "character")
  expect_equal(class(leagues$league), "character")
})

test_that("missing", {
  expect_equal(TRUE, all(!is.na(leagues)))
})
