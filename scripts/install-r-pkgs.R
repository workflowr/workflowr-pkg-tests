#!/usr/bin/env Rscript

if (!requireNamespace("remotes", quietly = TRUE)) {
  cat("Installing remotes\n")
  install.packages("remotes", repos = "https://cran.rstudio.com/")
}

cat("Installing outdated dependencies\n")
remotes::install_deps(pkgdir = "/tmp/workflowr", dependencies = TRUE)
