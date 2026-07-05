## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
has_sfn <- requireNamespace("sfnetworks", quietly = TRUE)
has_tg  <- requireNamespace("tidygraph", quietly = TRUE)

## ----setup--------------------------------------------------------------------
library(osmnxr)
g <- ox_example("olinda") # a small real network bundled with the package

## -----------------------------------------------------------------------------
parts <- ox_as_sf(g)
parts$edges

## ----eval = has_sfn-----------------------------------------------------------
# net <- ox_as_sfnetwork(g)
# net

## ----eval = has_tg------------------------------------------------------------
# tg <- ox_as_tidygraph(g)
# tg

## ----eval = FALSE-------------------------------------------------------------
# library(dodgr)
# graph <- ox_as_dodgr(g)
# dodgr_dists(graph, from = graph$from_id[1], to = graph$to_id[10])

## -----------------------------------------------------------------------------
gj <- tempfile(fileext = ".geojson")
ox_to_geojson(g, gj)

style <- ox_to_maplibre(g, tempfile(fileext = ".geojson"))
str(style, max.level = 2)

## -----------------------------------------------------------------------------
f <- tempfile(fileext = ".graphml")
ox_save_graphml(g, f)
g2 <- ox_load_graphml(f)
ox_basic_stats(g2)

