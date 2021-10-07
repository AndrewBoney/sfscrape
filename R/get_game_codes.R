get_game_codes <- function() {
  # define base url
  base_url <- "https://sofifa.com"

  ## Reading date codes
  #  SoFIFA has archived data going back a while. For this they have unique codes for each date, which allows
  #  you to combine that code with player / team data to read archived data for that date.
  html <- rvest::read_html(base_url)

  # Read nodes with bp3-menu as the class tag, which contains all dropdown options
  elements <- rvest::html_elements(html, xpath = "//div[contains(@class,'bp3-menu')]")
  children <- rvest::html_children(elements)

  # Extract text options and the codes that these equate to
  output <- rvest::html_text(children)
  full_string <- stringr::str_remove_all(rvest::html_attr(children, "href"), "/")
  code <- stringr::str_extract(full_string, "[0-9]{6,6}")
  comb <- data.frame(output = output, full_string = full_string, code = code)
  fifa <- dplyr::filter(comb, stringr::str_detect(output, "FIFA"))

  return(fifa)
}
