library(gapminder)
library(dplyr)
library(ggplot2)

# Create gapminder_1952 by filtering for the year 1952
gapminder_1952 <- gapminder %>% filter(year == 1952)
glimpse(gapminder_1952)
head(gapminder_1952)

#ScatterPlot
ggplot(gapminder_1952, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

#Log Scales
ggplot(gapminder_1952, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + scale_x_log10()

# Adding Color & Size Aesthetic
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()

# Creating a subgraph for each continent
# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
gapminder %>% ggplot(aes(x=gdpPercap, y=lifeExp, color=continent,size=pop)) + geom_point() +
  facet_wrap(~year) + scale_x_log10()

# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>% group_by(year, continent) %>% 
  summarise(medianGdpPercap = median(gdpPercap))

head(by_year_continent)
# Create a line plot showing the change in medianGdpPercap by continent over time
by_year_continent %>% ggplot(aes(x = year, y = medianGdpPercap, color = continent)) + 
  geom_line() + expand_limits(y = 0)

# Summarize the median gdpPercap by year and continent in 1952
by_continent <- gapminder %>% filter(year == 1952) %>% group_by(continent) %>% 
  summarise(medianGdpPercap = median(gdpPercap))

head(by_continent)

# Create a bar plot showing medianGdp by continent
by_continent %>% ggplot(aes(x = continent, y = medianGdpPercap)) +
  geom_col()


# Create a histogram of population (pop), with x on a log scale
gapminder_1952 %>% ggplot(aes(x = pop)) +
  geom_histogram() + scale_x_log10()


# Add a title to this graph: "Comparing GDP per capita across continents"
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() + ggtitle(label = "Comparing GDP per capita across continents")

