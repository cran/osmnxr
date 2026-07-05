## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5, fig.height = 5.5)

## ----setup--------------------------------------------------------------------
library(osmnxr)
g <- ox_example("olinda")

## -----------------------------------------------------------------------------
orig <- ox_nearest_nodes(g, x = -34.8553, y = -8.0089)
dest <- ox_nearest_nodes(g, x = -34.8505, y = -8.0125)
route <- ox_shortest_path(g, orig, dest, weight = "length")
length(route) # nodes along the route

## -----------------------------------------------------------------------------
route_xy <- sf::st_coordinates(g$nodes)[match(route, g$nodes$osmid), ]
plot(g, col = "grey80", lwd = 0.6)
lines(route_xy, col = "#b7410e", lwd = 3)
points(route_xy[c(1, nrow(route_xy)), ], pch = 19, col = "#0d3b66", cex = 1.2)

## -----------------------------------------------------------------------------
g <- ox_add_edge_travel_times(g)
head(g$edges[c("highway", "length", "speed_kph", "travel_time")])

route_t <- ox_shortest_path(g, orig, dest, weight = "travel_time")
identical(route_t, route) # may differ: the fastest route is not always shortest

## -----------------------------------------------------------------------------
ox_k_shortest_paths(g, orig, dest, k = 3, weight = "travel_time")

## -----------------------------------------------------------------------------
centre <- ox_nearest_nodes(g, x = -34.8553, y = -8.0089)
iso <- ox_isochrone(g, centre, cutoffs = c(60, 120), weight = "travel_time")
iso[c("cutoff", "n_nodes")]

## -----------------------------------------------------------------------------
plot(g, col = "grey85", lwd = 0.6)
plot(sf::st_geometry(iso), add = TRUE, border = NA,
     col = grDevices::adjustcolor(c("#0d3b66", "#2a9d8f"), 0.4))

## -----------------------------------------------------------------------------
hubs <- ox_nearest_nodes(g,
  x = c(-34.8553, -34.8505, -34.852),
  y = c(-8.0089, -8.0125, -8.006))
round(ox_distance_matrix(g, hubs, hubs, weight = "travel_time"))

