library(tidyverse)
library(janitor)

tbl <-
  list.files(path = "slides/data/football_database", 
             pattern = "\\.csv$", full.names = TRUE) %>% 
  sapply(read_csv)

games <- tbl[[2]]  %>% clean_names()
leagues <- tbl[[3]]  %>% clean_names()
teams <- tbl[[6]] %>% clean_names()


library(dm)
football_dm_no_keys <- dm(games, leagues, teams)


football_dm_no_keys
names(football_dm_no_keys)




football_dm_only_pks <-
  football_dm_no_keys %>%
  dm_add_pk(games, game_id) %>%
  dm_add_pk(leagues, league_id) %>%
  dm_add_pk(teams, team_id) 


dm_enum_fk_candidates(
  dm = football_dm_only_pks,
  table = games,
  ref_table = leagues
)


football_database <-
  football_dm_only_pks %>%
  dm_add_fk(table = games, columns = league_id, ref_table = leagues) %>%
  dm_add_fk(table = games, columns = home_team_id, ref_table = teams) %>%
  dm_add_fk(table = games, columns = away_team_id, ref_table = teams)

football_database %>%
  dm_draw(rankdir = "LR", view_type = "keys_only")

save(football_database, file = "slides/data/football_database/football_database.RData")


