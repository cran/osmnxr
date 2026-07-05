## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5, fig.height = 5.5)

## ----setup--------------------------------------------------------------------
library(osmnxr)

## ----eval = FALSE-------------------------------------------------------------
# g <- ox_graph_from_place("Olinda, Brazil", network_type = "drive")
# g <- ox_simplify(g)

## -----------------------------------------------------------------------------
g <- ox_example("olinda")
g

## -----------------------------------------------------------------------------
plot(g)

## -----------------------------------------------------------------------------
ox_basic_stats(g)

## -----------------------------------------------------------------------------
orig <- ox_nearest_nodes(g, x = -34.8553, y = -8.0089)
dest <- ox_nearest_nodes(g, x = -34.8505, y = -8.0125)
route <- ox_shortest_path(g, orig, dest)
length(route) # nodes along the route

## -----------------------------------------------------------------------------
route_xy <- sf::st_coordinates(g$nodes)[match(route, g$nodes$osmid), ]
plot(g, col = "grey80", lwd = 0.6)
lines(route_xy, col = "#b7410e", lwd = 3)

