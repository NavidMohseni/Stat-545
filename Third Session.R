#Determine the presence or the absence of a literal string with str_detect().
library(tidyverse)

fruit
str_detect(fruit, pattern = "fruit")

#wrapper around str_detect()
str_subset(fruit, pattern = "fruit")

#split the strings
str_split(fruit, pattern = "")

#specify the number of splits
str_split_fixed(fruit, pattern = "", n = 2)

#use separate for dataframes or tibbles

#for the length of the string: str_length()
str_length(fruit)

#snip out string based on character position.
fruit %>% 
  str_sub(1, 3)

tibble(fruit) %>% 
  head() %>% 
  mutate(snip = str_sub(fruit, 1:6, 3:8))

x <- head(fruit, 3)
str_sub(x, 1, 3) <- "AAA"
x

#collapse a vector
head(fruit) %>% 
  str_c(collapse = ", ")

str_c(fruit[4:8], fruit[1:4], sep = " & ")

#combine variables (columns) of the dataframe with unite()
fruit_df <- tibble(
  fruit1 = fruit[1:4],
  fruit2 = fruit[5:8]
)

fruit_df %>% 
  unite("flavor_combo", fruit1, fruit2, sep = " & ")

#replace with str_replace().
str_replace(fruit, pattern = "fruit", replacement = "Chiz")
#str_replace_na() is so useful.
melons <- str_subset(fruit, pattern = "melon")
melons[2] <- NA
melons
str_replace_na(melons, "Unknown melon") 

tibble(melons) %>% 
  replace_na(replace = list(melons = "Unknown melon"))

#Regular Expressions
library(gapminder)

countries <- levels(gapminder$country)  
# . > any single character
# \n > for new line
# regexes are case-sensitive
# ^ > beginning of the string
# $ > end of the string
# \b > word boundary
# \B > Not a word boundary

str_subset(countries, pattern = "i.a")
str_subset(countries, pattern = "i.a$")
str_subset(countries, pattern = "^Ir")
str_subset(fruit, pattern = "\\bmelon")
str_subset(countries, pattern =  "[nls]ia$")
str_subset(countries, pattern = "[^nls]ia$")
str_split_fixed(fruit, pattern = "\\s", n = 2)
str_split_fixed(fruit, pattern = "[[:space:]]", n = 2)
str_subset(countries, "[[:punct:]]")

matches <- str_subset(fruit, pattern = "l.*e")
list(match = intersect(matches, str_subset(fruit, pattern = "l.+e")),
     no_match = setdiff(matches, str_subset(fruit, pattern = "l.+e")))

#What if you really need the plus sign to be a literal plus sign and not a regex quantifier? 
#You will need to escape it by prepending a backslash. 
#But wait . there's more! Before a regex is interpreted as a regular expression, 
#it is also interpreted by R as a string. And backslash is used to escape there as well. 
#So, in the end, you need to preprend two backslashes in order to match a literal plus sign in a regex.

library(lubridate)

now()
today()
