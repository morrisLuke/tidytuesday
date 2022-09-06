#Declare file location
here::i_am("2022-09-06-LEGO-Sets/manipulations.R")

#Load packages
library(here)
library(systemfonts)

#Load data via dataLoader script
source(
  here("2022-09-06-LEGO-Sets", "dataLoader.R")
)

complexityByYear <- all_df %>%
  filter(num_parts >= 10) %>%
  group_by(year) %>%
  filter(year > 1960) %>%
  summarize(
    n = n(),
    medianPieces = round(median(num_parts)),
    meanPieces = round(mean(num_parts))
  )

complexityByDecade <- all_df %>%
  filter(num_parts >= 10  & year > 1960) %>%
  mutate(
    decade = case_when(
      year > 1960 & year <= 1970~"1960s",
      year > 1970 & year <= 1980~"1970s",
      year > 1980 & year <= 1990~"1980s",
      year > 1990 & year <= 2000~"1990s",
      year > 2000 & year <= 2010~"2000s",
      year > 2010 & year <= 2020~"2010s",
      year > 2020 ~"2020s"
    )
  )  %>%
  group_by(decade) %>%
  summarize(
    n = n(),
    medianPieces = round(median(num_parts)),
    meanPieces = round(mean(num_parts))
  )

ggplot(complexityByYear, aes(year,meanPieces)) +
  geom_col() +
  coord_flip() +
  scale_x_reverse() +
  theme_bw()

decadeplot <- ggplot(complexityByDecade, aes(decade,meanPieces)) +
  geom_col(fill = "#18629e", alpha =  0.7) +
  geom_text(aes(label = meanPieces), 
            nudge_y = 15, 
            family = "Pally", 
            fontface = "bold",
            size =  5) +
  coord_flip() +
  scale_x_discrete(limits=rev) +
  labs(
    title = "Average LEGO Set Complexity by Decade",
    subtitle = "As judged by average number of pieces in a set",
    x = "",
    y = "Mean Number of Pieces in a Set",
    caption = "rebrickable"
  ) +
  theme_void() +
  theme(
    plot.title = element_text(family = "Pally", face = "bold"),
    plot.subtitle = element_text(family = "Pally"),
    axis.title = element_text(family = "Open Sans", margin = margin(10,0,0,0)),
    axis.text = element_text(family =  "Open Sans"),
    axis.text.y = element_text(margin  =  margin(0, -15, 0, 0)),
    plot.caption = element_text(family =  "Open Sans"),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_line(color = "#f7f7f7")
  )

ggsave("plot.png", decadeplot, dpi = "retina", height = 4, width = 6)
