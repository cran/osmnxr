## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 7, fig.height = 3)
has_ggplot <- requireNamespace("ggplot2", quietly = TRUE)

## ----setup--------------------------------------------------------------------
library(osmnxr)

## -----------------------------------------------------------------------------
g <- ox_example("olinda")
ox_orientation_entropy(g)

## ----eval = has_ggplot--------------------------------------------------------
ox_plot_orientation(g, title = "Olinda")

## -----------------------------------------------------------------------------
cities <- readRDS(system.file("extdata", "city_orientations.rds", package = "osmnxr"))
ent <- tapply(cities$bearing, cities$city, ox_orientation_entropy)
round(ent, 3)

## ----orientation-roses, eval = has_ggplot, fig.height = 3---------------------
library(ggplot2)

bins <- 36; bw <- 360 / bins
cities$sector <- (floor((cities$bearing %% 360) / bw) + 0.5) * bw
counts <- as.data.frame(table(city = cities$city, sector = cities$sector))
counts$sector <- as.numeric(as.character(counts$sector))

ggplot(counts, aes(sector, Freq)) +
  geom_col(width = bw, fill = "#0d3b66", colour = "white", linewidth = 0.1) +
  coord_polar(start = 0) +
  scale_x_continuous(limits = c(0, 360), breaks = seq(0, 315, 45),
                     labels = c("N", "NE", "E", "SE", "S", "SW", "W", "NW")) +
  facet_wrap(~ city) +
  labs(x = NULL, y = NULL,
       title = "Street orientation: ordered (Chicago) to organic (Rome)") +
  theme_minimal(base_size = 9) +
  theme(axis.text.y = element_blank(), panel.grid.minor = element_blank())

## ----eval = FALSE-------------------------------------------------------------
# g <- ox_graph_from_place("Manhattan, New York, USA", network_type = "drive") |>
#   ox_simplify()
# ox_orientation_entropy(g) # low: a famous grid
# ox_plot_orientation(g, title = "Manhattan")

