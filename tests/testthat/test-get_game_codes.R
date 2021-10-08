test_that("correct names", {
  expect_equal(colnames(get_game_codes()), c("game", "full_string", "code"))
})

test_that("correct structure", {
  expect_output(str(get_game_codes()), "data.frame")
})
