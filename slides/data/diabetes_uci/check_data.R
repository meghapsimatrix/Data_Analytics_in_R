diabetes_dat %>%
  group_by(high_bp, diabetes_binary) %>%
  summarize(n = n()) %>%
  mutate(p_diabetic = n / sum(n)) %>%
  ungroup() %>%
  filter(diabetes_binary == 1) %>%
  select(high_bp, p_diabetic) %>%
  spread(high_bp, p_diabetic) %>%
  rename(lo = `0`, hi = `1`) %>%
  mutate(variable = "BP") %>%
  select(variable, hi, lo)


lm(diabetes_binary ~ high_bp, data = diabetes_dat)


library(broom)
tidy(chisq.test(diabetes_dat$diabetes_binary, diabetes_dat$stroke))
