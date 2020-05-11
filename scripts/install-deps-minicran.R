#!/usr/bin/env Rscript

# Alternative to install-deps-github.R
#
# If I didn't need to manually add some dependencies to the dev version of
# packages that aren't yet on CRAN, I could have used the miniCRAN package to
# build the network much easier.

library(igraph)
library(miniCRAN)

deps_graph <- makeDepGraph("workflowr")
plot(deps_graph)
deps_sort <- topo_sort(deps_graph)
deps_sort <- as_ids(deps_sort)
str(deps_sort)
