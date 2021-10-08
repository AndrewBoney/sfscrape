#' get_players
#'
#' Lists players for a given team and date
#'
#' @param team_code Full code for the team you want to scrape. From sfscrape::get_teams. E.g.
#' @param date_code Code for the date you want to scrape. From sfscrape::get_dates
#'
#' @return data.frame with cols "player_id", "player_name", "player_code"
#' @export
#'
#' @examples
#'
#' # sfscrape::get_players("/team/10/manchester_city/", "220006")
#'
get_players <- function(team_code, date_code) {
  # read html page (team overview)
  html <- rvest::read_html(paste0("https://sofifa.com", team_code, date_code))
  # extract player links
  tmp <- html %>% rvest::html_elements(xpath = "//a[contains(@href,'/player/')]")

  # prepare empty data frame
  players <- data.frame(player_id = rep(NA, length(tmp)), player_name = NA, player_code = NA)

  # extract player IDs from links. The raw column comes as /player/xxxxxx/<player_name> ,
  # sometimes also followed by another code which I think is for date. str_extract takes
  # the first 6 dig reference
  players$player_code <- tmp %>% rvest::html_attr("href")
  players$player_id <- stringr::str_extract(players$player_code, "[0-9]+")
  players$player_name <- tmp %>% rvest::html_attr("data-tooltip")

  filter <- stringr::str_extract_all(players$player_code, "[0-9]+", simplify = TRUE)[,2]

  players <- unique(players[filter == date_code, ])
  return(players)
}
