# sfscrape
This package uses the rvest (R) package for web scraping to automatically collect scores from the FIFA video game series, with data taken from https://sofifa.com. This package is an updated version of the now deprecated package https://github.com/valentinumbach/SoFIFA.

# Installation
To install the package, run.
- If you don't have devtools installed, run.
``` r
install.packages("devtools")
```
- Then run. 
``` r
devtools::install_github("https://github.com/fpl-analytics/sfscrape")
library(sfscrape)
```

# Using 
The package contains various functions for pulling data from https://sofifa.com. The pipeline goes as follows:
1. Get fifa games listed on sofifa.com. ``` fifa_games <- sfscrape::get_game_codes() ```
2. Get the dates of updates. ``` dates <- get_dates(fifa_games)```
3. Get the leagues for a given date. ``` get_leagues(220006) ```
4. Get all teams for a given league & date. ``` teams <- get_teams(13, 220006) ```
5. Get players in a given team and date ``` players <- get_players("/team/9/liverpool/") ```
6. Get FIFA data for a given player and date ``` player_data <- get_player_data("https://sofifa.com/player/209331/mohamed-salah/220006/" ``` 

