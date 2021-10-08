#' get_leagues
#'
#' Gets all available leagues for a given year, from the dropdown in https://sofifa.com/teams
#'
#' @param game_code Should contain the code for a given fifa game, from sfscrape::get_game_codes
#'
#' @return df containing all leagues in FIFA
#' @export
#'
#' @examples
#'
#' # Returns all available leagues in FIFA 22
#' sfscrape::get_leagues(220006)
#'
#' # to get all games (requires purrr and dplyr installed)
#' fifa_games <- sfscrape::get_game_codes()
#' codes <- fifa_games$code
#' names(codes) <- fifa_games$game
#' all_leauges <- purrr::map_dfr(codes, get_leagues, .id = "game")
#'
get_leagues <- function(game_code) {
  # define base url
  base_url <- "https://sofifa.com"

  # navigate to "teams" tab, for the given game
  html <- rvest::read_html(paste0(base_url, "/teams", "?r=", game_code, "&set=true"))

  # data-placeholder="Leagues" indicates the league dropdown
  leagues <- html %>%
    rvest::html_elements(xpath = "//select[@data-placeholder='Leagues']")  %>%
    rvest::html_children() %>%
    rvest::html_children()

  # league names are contained in the text
  league_names <- leagues %>%
    rvest::html_text()

  # associated codes are in attr "value"
  codes <- leagues %>%
    rvest::html_attr("value")

  leagues <- data.frame(codes = codes, league = league_names)

  return(leagues)
}
