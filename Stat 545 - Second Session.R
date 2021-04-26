#Data Analysis 2
#Factors
library(tidyverse)
nlevels(gapminder$country)

#filtering does not remove factor levels
h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela") 
h_gap <- gapminder %>% 
  filter(country %in% h_countries)
nlevels(h_gap$country)

h_gap$country %>% 
  fct_drop() %>% 
  levels()

gapminder %>% 
  filter(pop < 250000) %>% 
  mutate(country = fct_drop(country),
         continent = fct_drop(continent))

#the usage of fct_rev() and fct_infreq()
#Do the reordering either by frequency or another quantitative variable.
#The factor is the grouping variable and the default summarizing function is median().

gapminder$continent %>% 
  fct_infreq() %>%
  levels()

gapminder$continent %>% 
  fct_infreq() %>% 
  fct_rev() %>% 
  levels()

gapminder$country %>% 
  fct_reorder(gapminder$lifeExp) %>% 
  levels()

gapminder$country %>% 
  fct_reorder(gapminder$lifeExp, min) %>% 
  levels()

gapminder$country %>% 
  fct_reorder(gapminder$lifeExp, .desc = TRUE) %>% 
  levels()

gapminder %>% filter(year == 2007, continent == "Asia") %>% 
ggplot(aes(x = lifeExp, y = fct_reorder(country, lifeExp))) +
  geom_point()

#fct_relevel() to make some levels upfront.
#fct_recode() to recode the names of the levels.
i_gap <- gapminder %>% 
  filter(country %in% c("United States", "Sweden", "Australia")) %>% 
  droplevels()
i_gap$country %>% levels()
i_gap$country %>%
  fct_recode("USA" = "United States", "Oz" = "Australia") %>% 
  levels()

#fct_c() to combine levels.
