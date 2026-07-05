## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----setup--------------------------------------------------------------------
library(osmnxr)

## ----fig.width = 4.5, fig.height = 4.5----------------------------------------
g <- ox_example("olinda")
ox_plot_figure_ground(g)

## ----fig.width = 7.2, fig.height = 2.6----------------------------------------
op <- par(mfrow = c(1, 3))
ox_plot_figure_ground(ox_example("manhattan"), title = "Manhattan")
ox_plot_figure_ground(ox_example("olinda"),    title = "Olinda")
ox_plot_figure_ground(ox_example("rome"),      title = "Rome")
par(op)

## ----eval = FALSE-------------------------------------------------------------
# places <- c("Barcelona, Spain", "Tunis, Tunisia", "Salt Lake City, Utah, USA")
# op <- par(mfrow = c(1, 3))
# for (p in places) {
#   g <- ox_graph_from_address(p, dist = 800, network_type = "drive") |>
#     ox_simplify()
#   ox_plot_figure_ground(g, title = p)
# }
# par(op)

