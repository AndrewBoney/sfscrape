#' get_player_data
#'
#' Scrapes player data from https://sofifa.com.
#'
#' @param player_code Code associated with a player. Get list of player codes for a given team / date with sfscrape::get_players. Value should be a url suffix like "/player/210257/ederson-santana-de-moraes/220006/"
#'
#' @return df with cols "attribute" and "rating"
#' @export
#'
#' @examples
#'
#' sfscrape::get_player_data("/player/210257/ederson-santana-de-moraes/220006/")
#'
get_player_data <- function(player_code) {
  # read html page (player profile)
  html <- rvest::read_html(paste0("https://sofifa.com", player_code))

  all_attrs <- html %>%
    rvest::html_elements("div.card")

  filter <- all_attrs %>%
    rvest::html_element("h5") %>%
    rvest::html_text2()

  groups <- c("Attacking", "Skill", "Movement", "Power", "Mentality", "Defending", "Goalkeeping")
  scores <- all_attrs[filter %in% groups] %>%
    rvest::html_elements("ul") %>%
    rvest::html_children() %>%
    rvest::html_text2()

  player <- stringr::str_split(scores, " ", n = 2, simplify = T) %>%
    as.data.frame()
  colnames(player) <- c("attibute", "rating")

  return(player)
}
