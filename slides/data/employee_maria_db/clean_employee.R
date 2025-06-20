library(RMariaDB)
library(tidyverse)
library(RSQLite)
library(dbplyr)
library(dm)

# connect to sqlite database
my_db <- dbConnect(
  MariaDB(),
  user = 'guest',
  password = 'ctu-relational',
  dbname = 'employee',
  host = 'relational.fel.cvut.cz'
)

DBI::dbListTables(my_db)
employees <- my_db %>% tbl("employees") %>% clean_names()
salaries <- my_db %>% tbl("salaries") %>% clean_names()
dept_manager <- my_db %>% tbl("dept_manager") %>% clean_names()
dept_emp <- my_db %>% tbl("dept_emp") %>% clean_names()
titles <- my_db %>% tbl("titles") %>% clean_names()
departments <- my_db %>% tbl("departments") %>% clean_names()


employees <- as_tibble(employees)
salaries <- as_tibble(salaries)
dept_manager <- as_tibble(dept_manager)
dept_emp <- as_tibble(dept_emp)
titles <- as_tibble(titles)
departments <- as_tibble(departments)


my_dm <- dm_from_src(my_db)

my_dm

my_dm %>%
  dm_draw(rankdir = "LR", view_type = "keys_only")

employee_dm_keys <- dm(employees, salaries, dept_manager, 
                          dept_emp, titles, departments)


save(employee_dm_keys, file = "slides/data/employee_maria_db/employee_db.RData")

employee_dm_keys$employees
