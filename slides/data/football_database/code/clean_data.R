library(tidyverse)
library(janitor)

tbl <-
  list.files(path = "slides/data/football_database", 
             pattern = "\\.csv$", full.names = TRUE) %>% 
  sapply(read_csv)

appearances <- tbl[[1]] %>% clean_names()
games <- tbl[[2]]  %>% clean_names()
leagues <- tbl[[3]]  %>% clean_names()
players <- tbl[[4]]  %>% clean_names()
shots <- tbl[[5]]  %>% clean_names()
teams <- tbl[[6]] %>% clean_names()
teamstats <- tbl[[7]] %>% clean_names()


library(dm)
football_dm_no_keys <- dm(appearances, games, leagues, players, shots, teams, teamstats)


football_dm_no_keys
names(football_dm_no_keys)


dm_enum_pk_candidates(
  dm = football_dm_no_keys,
  table = shots
)


football_dm_only_pks <-
  football_dm_no_keys %>%
  dm_add_pk(table = players, columns = player_id) %>%
  dm_add_pk(games, game_id) %>%
  dm_add_pk(leagues, league_id) %>%
  dm_add_pk(teams, team_id) 


dm_enum_fk_candidates(
  dm = football_dm_only_pks,
  table = games,
  ref_table = leagues
)


football_dm_all_keys <-
  football_dm_only_pks %>%
  dm_add_fk(table = games, columns = league_id, ref_table = leagues) %>%
  dm_add_fk(table = appearances, columns = player_id, ref_table = players) %>%
  dm_add_fk(table = appearances, columns = game_id, ref_table = games) %>%
  dm_add_fk(table = appearances, columns = league_id, ref_table = leagues) %>%
  dm_add_fk(table = teamstats, columns = game_id, ref_table = games) %>%
  dm_add_fk(table = teamstats, columns = team_id, ref_table = teams) %>%
  dm_add_fk(table = shots, columns = game_id, ref_table = games) %>%
  dm_add_fk(table = shots, columns = shooter_id, ref_table = players) %>%
  dm_add_fk(table = shots, columns = assister_id, ref_table = games)

football_dm_all_keys %>%
  dm_draw(rankdir = "LR", view_type = "keys_only")

save(football_dm_all_keys, file = "slides/data/football_database/football_data.RData")


