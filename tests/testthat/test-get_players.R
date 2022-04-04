players <- get_players("/team/9/liverpool/", 220006)

test_that("colnames", {
  expect_equal(colnames(players), c("player_id", "player_name", "player_code"))
})

test_that("types", {
  expect_equal(class(players), "data.frame")
  expect_equal(class(players$player_id), "character")
  expect_equal(class(players$player_name), "character")
  expect_equal(class(players$player_code), "character")
})

test_that("missing", {
  expect_equal(TRUE, all(!is.na(players)))
})

