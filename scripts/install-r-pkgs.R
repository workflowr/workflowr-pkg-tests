#!/usr/bin/env Rscript

cat("Installing remotes\n")
if (!requireNamespace("remotes", quietly = TRUE))
  install.packages("remotes", repos = "https://cran.rstudio.com/")

cat("Installing outdated dependencies\n")
remotes::install_deps(pkgdir = "/tmp/workflowr", dependencies = TRUE)
