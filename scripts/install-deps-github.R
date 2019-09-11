#!/usr/bin/env Rscript

# Install package dependencies from GitHub.

library(igraph)
library(remotes)
library(stringr)
library(tools)

dry_run <- FALSE

pkg <- "workflowr"
deps <- tools::package_dependencies(pkg, which = "most")
deps_rec <- tools::package_dependencies(deps[[1]], recursive = TRUE)
deps_all <- unique(c(deps[[1]], unlist(deps_rec)))
deps_list <- Map(function(x) tools::package_dependencies(x)[[1]], deps_all)
deps_list["workflowr"] <- deps # Only workflowr should incldue suggested deps

list_to_df <- function(name, vec) {
  if (is.null(vec) || length(vec) == 0) return(NULL)

   data.frame(dependency = vec, package = name, stringsAsFactors = FALSE)
}

deps_df <- mapply(list_to_df, as.list(names(deps_list)), deps_list)
deps_df <- do.call(rbind, deps_df)

deps_dag <- igraph::graph_from_data_frame(deps_df)
igraph::plot.igraph(deps_dag)
deps_sort <- igraph::topo_sort(deps_dag)
deps_sort <- igraph::as_ids(deps_sort)

# Remove base packages
deps_sort <- setdiff(deps_sort, rownames(installed.packages(priority="base")))
# Remove workflowr
deps_sort <- setdiff(deps_sort, "workflowr")

crandb <- CRAN_package_db()

cran <- character()
for (pkg in deps_sort) {
  pkg_url <- crandb$URL[crandb$Package == pkg]
  pkg_bugs <- crandb$BugReports[crandb$Package == pkg]
  gh_repo <- stringr::str_match(c(pkg_url, pkg_bugs),
                                sprintf("github.com/(.+/%s)", pkg))
  gh_repo <- unique(na.omit(gh_repo)[, 2])
  # Handle edge cases
  if (pkg == "assertthat") gh_repo <- "hadley/assertthat"
  if (pkg == "BH") gh_repo <- "eddelbuettel/bh"
  if (pkg == "lazyeval") gh_repo <- "hadley/lazyeval"
  if (pkg == "magrittr") gh_repo <- "tidyverse/magrittr"
  if (pkg == "miniUI") gh_repo <- "rstudio/miniUI"
  if (pkg == "reshape2") gh_repo <- "hadley/reshape"
  if (pkg == "roxygen2") gh_repo <- "r-lib/roxygen2"
  if (pkg == "yaml") gh_repo <- "viking/r-yaml"
  if (length(gh_repo) == 1) {
    cat(sprintf("==== Installing %s from GitHub ===='\n", gh_repo))
    if (!dry_run) remotes::install_github(gh_repo, dependencies = FALSE)
  } else {
    cran <- c(cran, pkg)
    cat(sprintf("==== Installing %s from CRAN ====\n", pkg))
    if (!dry_run) install.packages(pkg, dependencies = FALSE)
  }
}



