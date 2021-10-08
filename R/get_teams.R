#' get_teams
#'
#' Gets all teams in a given league / year
#'
#' @param league_id  Code for league, from sfscrape::get_leagues
#' @param date_code  Code for date, from sfscrape::get_game_codes
#'
#' @return df teams, with cols for "team_name", "team_id", "team_code", "date_code"
#' @export
#'
#' @examples
#'
#' # returns teams from 13 (Premier League), for date 220006 (FIFA 22)
#' sfscrape::get_teams(13, 220006)
#'
#' # returns teams in all premier league season, for all seasons available FIFA 07 onwards
#' fifa_games <- sfscrape::get_game_codes()
#' codes <- fifa_games$code
#' names(codes) <- fifa_games$game
#' all_teams <- purrr::map_dfr(codes, ~get_teams(13, .x), .id = "game")
#'
get_teams <- function(league_id, date_code) {
  # define base url
  base_url <- "https://sofifa.com"
  # build url
  url <- paste0(base_url, "/teams?lg=", league_id, "&r=", date_code, "&set=true")
  # read html page (league overview)
  html <- rvest::read_html(url)
  # extract team links
  tmp <- html %>% rvest::html_elements(xpath = "//a[contains(@href,'/team/')]")
  # extract team IDs from links
  team_codes <- tmp %>% rvest::html_attr("href")

  temp <- stringr::str_extract_all(team_codes, "[0-9]", simplify = TRUE)
  team_id <- do.call(paste0, as.data.frame(temp))

  # extract team names from links
  teams <- data.frame(team_id = rep(0, length(tmp)), team_name = NA,
                      team_code = NA, date_code = NA)
  teams$team_name <- rvest::html_text(tmp)
  teams$team_id <- team_id
  teams$team_code <- team_codes
  teams$date_code <- date_code

  # return data frame
  teams
}
