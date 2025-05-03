library(tidyverse)

capital_bike_sharing <- read_csv("slides/class_02_data_visualization/data/capital_bike_sharing.csv")

glimpse(capital_bike_sharing)

table(capital_bike_sharing$season)
table(capital_bike_sharing$weekday)

capital_bike_sharing_clean <- 
  capital_bike_sharing %>%
  mutate(season = case_when(season == 1 ~ "winter",
                            season == 2 ~ "spring",
                            season == 3 ~ "summer",
                            season == 4 ~ "fall"),
         yr = ifelse(yr == 0, 2011, 2012),
         holiday = ifelse(holiday == 1, "Holiday", "No Holiday"),
         weekday = case_when(weekday == 0 ~ "Sunday",
                             weekday == 1 ~ "Monday",
                             weekday == 2 ~ "Tuesday",
                             weekday == 3 ~ "Wednesday",
                             weekday == 4 ~ "Thursday",
                             weekday == 5 ~ "Friday",
                             weekday == 6 ~ "Saturday"),
         workingday = ifelse(workingday == 1, "Working Day", "Holiday"),
         weathersit = case_when(weathersit == 1 ~ "Clear",
                             weathersit == 2 ~ "Misty and Cloudy",
                             weathersit == 3 ~ "Rainy or Snowy"
                             )) %>%
  rename(count = cnt)

table(capital_bike_sharing_clean$season)
table(capital_bike_sharing_clean$weathersit)


ggplot(capital_bike_sharing_clean, aes(x = count)) +
  geom_density() + 
  facet_wrap(~ weathersit)




glimpse(capital_bike_sharing_clean)

bike_sharing_dat <- capital_bike_sharing_clean

save(bike_sharing_dat, file = "slides/data/bike_sharing_dat.RData")
