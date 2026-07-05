## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5, fig.height = 5.5)

## ----setup--------------------------------------------------------------------
library(osmnxr)

## ----eval = FALSE-------------------------------------------------------------
# # schools in a place
# ox_features_from_place("Olinda, Brazil", tags = list(amenity = "school"))
# 
# # the amenities studied in accessibility research, in one call
# ox_features_from_place(
#   "Recife, Brazil",
#   tags = list(amenity = c("school", "hospital", "pharmacy", "marketplace"))
# )
# 
# # every building footprint (key present, any value)
# ox_features_from_place("Olinda, Brazil", tags = list(building = TRUE))
# 
# # parks and green space
# ox_features_from_place("Recife, Brazil", tags = list(leisure = "park"))
# 
# # public transit stops
# ox_features_from_place("Recife, Brazil", tags = list(public_transport = "stop_position"))

## ----eval = FALSE-------------------------------------------------------------
# bbox <- c(-34.91, -8.07, -34.87, -8.04)
# pois <- ox_features_from_bbox(bbox, tags = list(amenity = c("pharmacy", "clinic")))
# pois

## ----eval = FALSE-------------------------------------------------------------
# library(dplyr)
# pois |>
#   st_drop_geometry() |>
#   count(amenity, sort = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# g <- ox_graph_from_place("Olinda, Brazil", network_type = "walk") |>
#   ox_simplify() |>
#   ox_add_edge_travel_times()
# 
# schools <- ox_features_from_place("Olinda, Brazil", tags = list(amenity = "school"))
# xy <- sf::st_coordinates(schools)
# nodes <- ox_nearest_nodes(g, xy[, 1], xy[, 2])
# 
# # 15-minute walking catchment around every school
# ox_isochrone(g, nodes, cutoffs = 900, weight = "travel_time")

