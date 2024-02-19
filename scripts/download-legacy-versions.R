#!/usr/bin/env Rscript

# Download legacy versions of workflowr dependencies. Supports the legacy job
# defined in .github/workflows/legacy.yaml

output <- "data/legacy-package-versions.csv"
snapshot <- "2018-05-03"

suppressPackageStartupMessages({
  library(igraph)
  library(miniCRAN)
})

# Download available package versions from MRAN snapshot
# https://mran.microsoft.com/timemachine
mranUrl <- sprintf("https://packagemanager.posit.co/cran/%s", snapshot)

mran <- available.packages(contrib.url(mranUrl, "source"))

# Add more recent dependencies
imports <- mran["workflowr", "Imports"]
mran["workflowr", "Imports"] <- paste0(imports, ", fs, httpuv, httr, xfun")
suggests <- mran["workflowr", "Suggests"]
# replace devtools with sessioninfo
suggests <- sub("devtools", "sessioninfo", suggests)
mran["workflowr", "Suggests"] <- paste0(suggests,
                                        ", clipr, miniUI, reticulate, shiny")
# Remove covr
mran["workflowr", "Suggests"] <- sub("covr,\\s", "", mran["workflowr", "Suggests"])

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
# same situation with Matrix
depsSorted <- depsSorted[!depsSorted == "Matrix"]

# Get versions
deps <- mran[depsSorted, c("Package", "Version")]
deps <- as.data.frame(deps, stringsAsFactors = FALSE)
colnames(deps) <- tolower(colnames(deps))

# Update minimum versions as required for latest version of workflowr
deps["callr", "version"] <- "3.7.0"
deps["cli", "version"] <- "1.1.0"
deps["clipr", "version"] <- "0.7.0"
deps["evaluate", "version"] <- "0.13"
deps["fs", "version"] <- "1.2.7"
deps["git2r", "version"] <- "0.26.0"
deps["knitr", "version"] <- "1.29"
deps["later", "version"] <- "0.7.4"
deps["reticulate", "version"] <- "1.15"
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

# Install ps and processx before callr
callrIndex <- which(deps$package == "callr")
deps <- rbind(
  deps[1:(callrIndex-1), ],
  data.frame(package = c("ps", "processx"), version = c("1.2.0", "3.5.0"),
             row.names = c("ps", "processx"), stringsAsFactors = FALSE),
  deps[callrIndex:nrow(deps), ]
)
depsSorted <- c(
  depsSorted[1:(callrIndex-1)],
  c("ps", "processx"),
  depsSorted[callrIndex:length(depsSorted)]
)

# Install rappdirs before reticulate, a new depenency added between 1.7 and 1.15
reticulateIndex <- which(deps$package == "reticulate")
deps <- rbind(
  deps[1:(reticulateIndex-1), ],
  data.frame(package = "rappdirs", version = "0.3.1",
             row.names = "rappdirs", stringsAsFactors = FALSE),
  deps[reticulateIndex:nrow(deps), ]
)
depsSorted <- c(
  depsSorted[1:(reticulateIndex-1)],
  "rappdirs",
  depsSorted[reticulateIndex:length(depsSorted)]
)

# Check current versions
current <- available.packages()
current <- current[depsSorted, c("Package", "Version")]
current <- as.data.frame(current, stringsAsFactors = FALSE)
colnames(current) <- tolower(colnames(current))
deps[, "status"] <- ifelse(deps[, "version"] == current[, "version"],
                           "current", "archive")

write.csv(deps, file = output, quote = FALSE, row.names = FALSE)
