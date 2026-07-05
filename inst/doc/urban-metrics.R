## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5, fig.height = 5.5)

## ----setup--------------------------------------------------------------------
library(osmnxr)

## -----------------------------------------------------------------------------
g <- ox_example("olinda")
g

## -----------------------------------------------------------------------------
ox_basic_stats(g)

## -----------------------------------------------------------------------------
area_km2 <- as.numeric(sf::st_area(sf::st_convex_hull(sf::st_union(g$nodes)))) / 1e6
n_intersections <- sum(g$nodes$osmid %in% c(g$edges$u, g$edges$v))
n_intersections / area_km2 # intersections per km^2

## -----------------------------------------------------------------------------
ox_circuity(g)

## -----------------------------------------------------------------------------
ct <- ox_centrality(g, type = "betweenness", normalized = TRUE)
ct[order(-ct$betweenness), ][1:5, ]

## -----------------------------------------------------------------------------
nodes <- g$nodes
nodes$betweenness <- ct$betweenness[match(nodes$osmid, ct$osmid)]
plot(g, col = "grey80", lwd = 0.6)
plot(nodes["betweenness"], pch = 19,
     cex = 0.4 + 4 * nodes$betweenness / max(nodes$betweenness),
     pal = function(n) hcl.colors(n, "YlOrRd", rev = TRUE), add = TRUE)

