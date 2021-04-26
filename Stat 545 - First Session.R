library(gapminder)

#See the structure
str(gapminder)

#Best library ever
library(tidyverse)
gapminder
class(gapminder)

#Useful functions in R Basic
head()
tail()
as_tibble()
names()
ncol()
nrow()
length()
dim()

#Data frames are a special case where the length of each list component is the same.
#Use $ to access a component of a variable.
barplot(table(gapminder$continent))

#Filter your results with pipeline
gapminder %>% filter(country == "Iran", year > 2002)
gapminder %>% filter(country %in% c("Iran","Netherlands"))

#Use View() more often.
gapminder %>% 
  filter(country %in% c("Iran", "Netherlands")) %>% 
  select(country, lifeExp, year) %>% 
  View()

#You can even rename in select() or rename() function.
gapminder %>% 
  rename(life_exp = lifeExp)

#Same ways to bring count() on the table.
gapminder %>% 
  group_by(continent) %>% 
  tally()

gapminder %>% 
  count(continent)

gapminder %>% 
  group_by(continent) %>% 
  summarize(n = n(),
            v = n_distinct(country))

#summarize_at()
gapminder %>% 
  filter(year %in% c(1952, 2007)) %>% 
  group_by(year, continent) %>% 
  summarize_at(vars(lifeExp, gdpPercap), list(~mean(.), ~max(.)))


#Usage of first(), lag(), or window functions like rank().
gapminder %>% 
  group_by(country) %>% 
  select(country, year, lifeExp) %>% 
  mutate(lifeExp_gain = lifeExp - first(lifeExp)) %>% 
  filter(year < 1963)

gapminder %>% 
  filter(continent == "Asia") %>% 
  select(year, country, lifeExp) %>% 
  group_by(year) %>% 
  filter(min_rank(lifeExp) > 2, min_rank(desc(lifeExp)) < 2) %>%
  arrange(year) %>% 
  print(n = Inf)

#Which country experienced the sharpest 5-year drop in life expectancy?
gapminder %>% 
  group_by(continent, country) %>% 
  mutate(diff = lifeExp - lag(lifeExp)) %>% 
  summarize(worst_diff = min(diff, na.rm = TRUE)) %>% 
  top_n(-1, wt = worst_diff) %>% 
  arrange((worst_diff))
   
