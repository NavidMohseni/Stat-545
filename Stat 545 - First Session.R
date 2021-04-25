library(gapminder)

#See the structure
str(gapminder)

#Best library ever
library(tidyverse)
gapminder
class(gapminder)

#Useful functions
head()
tail()
as_tibble()
names()
ncol()
nrow()
length()
dim()

#Data frame are a special case where the length of each list component is the same.
barplot(table(gapminder$continent))

#Filter your results with pipeline
gapminder %>% filter(country == "Iran", year > 2002)
gapminder %>% filter(country %in% c("Iran","Netherlands"))

gapminder %>% 
  filter(country %in% c("Iran", "Netherlands")) %>% 
  select(country, lifeExp, year) %>% 
  View()

#You can even rename in select() or rename() function
gapminder %>% 
  rename(life_exp = lifeExp)

#Same way
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
