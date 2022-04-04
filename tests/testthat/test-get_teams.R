# TODO: test other versions
teams <- get_teams(13, 220006)

test_that("colnames", {
  expect_equal(colnames(teams), c("team_id", "team_name", "team_code", "date_code"))
})

test_that("types", {
  expect_equal(class(teams), "data.frame")
  expect_equal(class(teams$team_id), "character")
  expect_equal(class(teams$team_name), "character")
  expect_equal(class(teams$team_code), "character")
  expect_equal(class(teams$date_code), "numeric")
})

test_that("missing", {
  expect_equal(TRUE, all(!is.na(teams)))
})
