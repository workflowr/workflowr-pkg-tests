# workflowr-pkg-tests

[![CircleCI](https://circleci.com/gh/workflowr/workflowr-pkg-tests/tree/master.svg?style=svg)](https://circleci.com/gh/workflowr/workflowr-pkg-tests/tree/master)

This repository contains additional tests of the R package [workflowr][].


[workflowr]: https://github.com/jdblischak/workflowr

Name  | Purpose
------------- | -------------
future        | Catch future errors by installing development versions of dependencies
devel         | Run tests with development version of R
r361          | Run tests with R 3.6.1
r353          | Run tests with R 3.5.3
pandoc_one    | Run tests with pandoc 1.19 (breaking changes introduced in pandoc 2+)
rmd_1.7       | Run tests with min versions of rmarkdown 1.7 (first version that supports pandoc 2+) and knitr 1.18 (first version to export functions used by rmarkdown 1.10+)
callr_3.3.0   | Run tests for handling callr 3.3.0 behavior (writing `data`/`env` to the global environment)
