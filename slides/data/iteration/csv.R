library(matchMulti)

data(catholic_schools)




school_list <- catholic_schools %>%
  filter(school %in% unique(catholic_schools$school)[1:20]) %>%
  group_split(school)

school_list %>%
  purrr::map(~pull(.,school)) %>%
  purrr::map(~unique(.)) -> names(school_list) #

names(school_list)



output_csv <- function(data, names){ 
  folder_path <- "practice_problems/data/school_data/"
  
  write_csv(data, paste0(folder_path, "school-", names, ".csv"))
}
# Step 2
list(data = school_list,
     names = names(school_list)) %>% 
  
  # Step 3
  purrr::pmap(output_csv) 



school_1477 <- read_csv("practice_problems/data/school_data/school-1477.csv")

school_1477$school <- as.character(school_1477$school)

write_csv(school_1477, "practice_problems/data/school_data/school-1477.csv")



school_2030 <- read_csv("practice_problems/data/school_data/school-2030.csv")

school_2030$school <- as.character(school_2030$school)

write_csv(school_2030, "practice_problems/data/school_data/school-2030.csv")

