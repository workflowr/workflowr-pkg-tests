#!/usr/bin/env Rscript

# Download legacy versions of workflowr dependencies. Supports the legacy job
# defined in .github/workflows/legacy.yaml

output <- "data/legacy-package-versions.csv"
snapshot <- "2018-05-01"

library(igraph)
library(miniCRAN)

# Download available package versions from MRAN snapshot
# https://mran.microsoft.com/timemachine
mranUrl <- sprintf("https://cran.microsoft.com/snapshot/%s/", snapshot)

mran <- available.packages(contrib.url(mranUrl, "source"))

# Add more recent dependencies
imports <- mran["workflowr", "Imports"]
mran["workflowr", "Imports"] <- paste0(imports, ", fs, httpuv, httr, xfun")
suggests <- mran["workflowr", "Suggests"]
mran["workflowr", "Suggests"] <- paste0(suggests,
                                             ", clipr, miniUI, reticulate, shiny, spelling")

# Sort topologically
depsGraph <- makeDepGraph(
  pkg = "workflowr",
  availPkgs = mran
)
depsSorted <- topo_sort(depsGraph)
depsSorted <- as_ids(depsSorted)

# remove workflowr
depsSorted <- depsSorted[-length(depsSorted)]

# remove lattice. It's causing issues (may be the dash in its version number or
# the fact that it's installed in the system library). Not worth troubleshooting
# since it's already installed
depsSorted <- depsSorted[!depsSorted == "lattice"]

# Get versions
deps <- mran[depsSorted, c("Package", "Version")]
deps <- as.data.frame(deps, stringsAsFactors = FALSE)
colnames(deps) <- tolower(colnames(deps))

# Update minimum versions as required for latest version of workflowr
deps["evaluate", "version"] <- "0.13"
deps["knitr", "version"] <- "1.29"
deps["rmarkdown", "version"] <- "1.18"
deps["xfun", "version"] <- "0.15"
deps["yaml", "version"] <- "2.1.19"

# Install tinytex after xfun, it's only dependency
xfunIndex <- which(deps$package == "xfun")
deps <- rbind(
  deps[1:xfunIndex, ],
  data.frame(package = "tinytex", version = "0.11",
             row.names = "tinytex", stringsAsFactors = FALSE),
  deps[(xfunIndex+1):nrow(deps), ]
)
depsSorted <- c(
  depsSorted[1:xfunIndex],
  "tinytex",
  depsSorted[(xfunIndex+1):length(depsSorted)]
)

# Check current versions
current <- available.packages()
current <- current[depsSorted, c("Package", "Version")]
current <- as.data.frame(current, stringsAsFactors = FALSE)
colnames(current) <- tolower(colnames(current))
deps[, "status"] <- ifelse(deps[, "version"] == current[, "version"],
                           "current", "archive")

write.csv(deps, file = output, quote = FALSE, row.names = FALSE)
