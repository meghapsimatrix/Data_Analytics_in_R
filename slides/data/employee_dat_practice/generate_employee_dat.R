library(tidyverse)

set.seed(20250629)

employee_dat <- tibble(emp_id = c(1:12), 
                       surv_scr = round(rnorm(12, 80, 5)), 
                       dept_id = rep(LETTERS[1:3], each = 4))


department_dat <- tibble(dept_id = c("A", "B", "D", "E"),
                         dept_name = c("Analytics", 
                                       "Research", "HR",
                                       "Admin"))

save(employee_dat, department_dat, file = "slides/data/employee_dat_practice/employee_database.RData")


full_dat <- full_join(employee_dat, department_dat, by = "dept_id")
left_dat <- left_join(employee_dat, department_dat, by = "dept_id")
right_dat <- right_join(employee_dat, department_dat, by = "dept_id")                         
inner_dat <- inner_join(employee_dat, department_dat, by = "dept_id")

