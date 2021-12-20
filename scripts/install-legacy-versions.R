#!/usr/bin/env Rscript

# Install legacy versions of dependencies

# Testing
# tmp <- tempfile()
# dir.create(tmp, showWarnings = FALSE)
# .libPaths(tmp)
# .libPaths()

pkgs <- read.csv("data/legacy-package-versions.csv", stringsAsFactors = FALSE)

isInstalled <- function(pkgName, pkgVersion) {
  requireNamespace(pkgName, quietly = TRUE) &&
    packageVersion(pkgName) == pkgVersion
}

for (i in seq_len(nrow(pkgs))) {
  pkg <- pkgs$package[i]
  pkgVersion <- pkgs$version[i]
  pkgStatus <- pkgs$status[i]
  if (isInstalled(pkg, pkgVersion)) {
    message("Already installed ", pkg, " ", pkgVersion)
    next
  }
  message("Installing ", pkg, " ", pkgVersion)
  if (pkgStatus == "archive") {
    tarball <- sprintf(
      "https://cran.r-project.org/src/contrib/Archive/%s/%s_%s.tar.gz",
      pkg, pkg, pkgVersion
    )
  } else {
    tarball <- sprintf(
      "https://cran.r-project.org/src/contrib/%s_%s.tar.gz",
      pkg, pkgVersion
    )
  }
  install.packages(tarball, repos = NULL, dependencies = FALSE)
  if (!isInstalled(pkg, pkgVersion)) {
    stop("Package ", pkg, " ", pkgVersion, " failed to install")
  }
}
