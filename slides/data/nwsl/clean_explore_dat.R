library(nwslR)
library(tidyverse)

# from the github page for this package 
matches_2022 <- load_matches() %>%
  dplyr::filter(season == 2022)

players <- load_players()

# * A small number of matches do not have data, so we wrap this in a safe call to ensure this runs without error 
safe_load_pms <- purrr::possibly(load_player_match_stats, otherwise = data.frame())

player_stats <- purrr::map_df(matches_2022$match_id, safe_load_pms, .progress = TRUE)



teams_2022 <- c("CHI", "HOU", "NJY", "RGN", "ORL", "POR", "WAS", "NC", "KCC", "LOU", "LA", "SD")

teams <- load_teams()

team_stats <- purrr::map_df(teams_2022, ~load_team_season_stats(team_id = .x, season = "2022"), .progress = TRUE)

