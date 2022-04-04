# TODO: test against wider range
dates <- get_dates("FIFA 22")
dates_2 <- get_dates(c("FIFA 22", "FIFA 21"))

test_that("colnames", {
  expect_equal(colnames(dates), c("full_string", "code", "game", "date"))
  expect_equal(colnames(dates), colnames(dates_2))
})

test_that("types", {
  expect_equal(class(dates), "data.frame")
  expect_equal(class(dates$full_string), "character")
  expect_equal(class(dates$code), "character")
  expect_equal(class(dates$game), "character")
  expect_equal(class(dates$date), "Date")
})

test_that("both", {
  unique_games <- unique(dates_2$game)

  expect_equal(unique_games, c("FIFA 22", "FIFA 21"))
})

test_that("missing", {
  expect_equal(TRUE, all(!is.na(dates)))
})
