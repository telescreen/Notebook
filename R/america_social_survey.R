# hours spent watching TV by religions
relig <- gss_cat %>%
  group_by(relig) %>%
  summarise(
    age = mean(age, na.rm=T),
    tvhours = mean(tvhours, na.rm = T),
    n = n()
  )
ggplot(relig, aes(tvhours, fct_reorder(relig, tvhours))) + geom_point()

# Income by age
rincome <- gss_cat %>%
  group_by(rincome) %>%
  summarise(
    age = mean(age, na.rm = T),
    tvhours = mean(tvhours, na.rm = T),
    n = n()
  )
ggplot(rincome, aes(age, fct_relevel(rincome, "Not applicable"))) + geom_point()

# Marrital status by age
by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  group_by(age, marital) %>%
  count() %>%
  mutate(prop = n / sum(n))
ggplot(by_age, aes(age, prop, colour = fct_reorder2(marital, age, prop))) +
  geom_line() +
  labs(colour = "marital")