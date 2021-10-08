#' get_dates
#'
#' Gets all dates listed on sofifa for player stat updates, as well as associated codes for the urls
#'
#' @param fifa_games - should be df containing cols "game", "full_string", "code", from sfscrape::get_games_codes
#'
#' @return df containing the dates for all games in input fifa_games df
#' @export
#'
#' @examples
#'
#' fifa_games <- sfscrape::get_game_codes()
#' dates <- sfscrape::get_dates(fifa_games)
#'
get_dates <- function(fifa_games) {
  bind_dates <- function(string, game) {
    html <- rvest::read_html(paste0("https://sofifa.com", string))

    # Read nodes with bp3-menu as the class tag, which contains all dropdown options
    elements <- rvest::html_elements(html, xpath = "//div[contains(@class,'bp3-menu')]")
    children <- rvest::html_children(elements)

    # Extract text options and the codes that these equate to
    output <- rvest::html_text(children)

    full_string <- rvest::html_attr(children, "href")

    code <- stringr::str_extract(full_string, "[0-9]{6,6}")

    comb <- data.frame(output = output, full_string = full_string, code = code)
    temp <- comb[stringr::str_detect(comb$output, "[0-9]{4,4}"), ]
    temp$game <- game
    return(temp)
  }

  dates <- purrr::map_df(1:nrow(fifa_games),
                         ~bind_dates(fifa_games$full_string[.x], fifa_games$game[.x]))

  dates$date <- as.Date(dates$output, format = "%b %d, %Y")
  dates$output <- NULL

  return(dates)
}

