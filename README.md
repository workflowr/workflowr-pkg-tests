# workflowr-pkg-tests

[![CircleCI](https://circleci.com/gh/workflowr/workflowr-pkg-tests/tree/master.svg?style=svg)](https://circleci.com/gh/workflowr/workflowr-pkg-tests/tree/master)

This repository contains additional tests of the R package [workflowr][].


[workflowr]: https://github.com/jdblischak/workflowr

Name  | Purpose
------------- | -------------
future        | Catch future errors by installing development versions of dependencies
devel         | Run tests with development version of R
r363          | Run tests with R 3.6.3
r353          | Run tests with R 3.5.3
r325          | Run tests with minimum required version of R (3.2.5)
pandoc_one    | Run tests with pandoc 1.19 (breaking changes introduced in pandoc 2+)
rmd_1.7       | Run tests with min versions of rmarkdown 1.7 (first version that supports pandoc 2+) and knitr 1.18 (first version to export functions used by rmarkdown 1.10+)
rmd_1.10      | Run tests with version of rmarkdown that [sets the pagetitle metadata when missing title][rmarkdown1355]
callr_3.3.0   | Run tests for handling callr 3.3.0 behavior (writing `data`/`env` to the global environment)
reticulate    | Test `wflow_html()` warning for [Python plots created with reticulate version < 1.14.9000][workflowr181]
speed         | Test speed of `wflow_publish()` for dev version compared to previous versions
git_time      | Catch timezone conversion errors (e.g. [git2r #407][git2r407])

[git2r407]: https://github.com/ropensci/git2r/issues/407
[rmarkdown1355]: https://github.com/rstudio/rmarkdown/pull/1355
[workflowr181]: https://github.com/jdblischak/workflowr/issues/181
