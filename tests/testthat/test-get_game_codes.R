game_codes <- get_game_codes()

test_that("colnames", {
  expect_equal(colnames(game_codes), c("game", "full_string", "code"))
})

test_that("types", {
  expect_equal(class(game_codes), "data.frame")
  expect_equal(class(game_codes$game), "character")
  expect_equal(class(game_codes$full_string), "character")
  expect_equal(class(game_codes$code), "character")
})
