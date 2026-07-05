## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5, fig.height = 5.5)

## ----setup--------------------------------------------------------------------
library(osmnxr)

## -----------------------------------------------------------------------------
g <- ox_add_edge_travel_times(ox_example("olinda"))

## -----------------------------------------------------------------------------
clinic <- ox_nearest_nodes(g, x = -34.8553, y = -8.0089)
iso <- ox_isochrone(g, clinic, cutoffs = c(60, 120, 180), weight = "travel_time")
iso[c("cutoff", "n_nodes")]

## -----------------------------------------------------------------------------
plot(g, col = "grey85", lwd = 0.6)
plot(sf::st_geometry(iso), add = TRUE, border = NA,
     col = grDevices::adjustcolor(c("#0d3b66", "#1f7a8c", "#2a9d8f"), 0.35))

## -----------------------------------------------------------------------------
homes <- ox_nearest_nodes(g,
  x = c(-34.8505, -34.852, -34.8585),
  y = c(-8.0125, -8.006, -8.011))
facilities <- ox_nearest_nodes(g,
  x = c(-34.8553, -34.8500),
  y = c(-8.0089, -8.0140))

m <- ox_distance_matrix(g, from = homes, to = facilities, weight = "travel_time")
round(m)                 # seconds, homes x facilities
round(apply(m, 1, min))  # travel time to the nearest facility

## ----eval = FALSE-------------------------------------------------------------
# g <- ox_graph_from_place("Olinda, Brazil", network_type = "drive") |>
#   ox_simplify() |>
#   ox_add_edge_travel_times()
# 
# hospitals <- ox_features_from_place("Olinda, Brazil", tags = list(amenity = "hospital"))
# xy <- sf::st_coordinates(hospitals)
# origins <- ox_nearest_nodes(g, xy[, 1], xy[, 2])
# 
# # 10- and 20-minute drive-time service areas across all hospitals
# ox_isochrone(g, origins, cutoffs = c(600, 1200), weight = "travel_time")

