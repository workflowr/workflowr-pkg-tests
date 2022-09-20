# workflowr-pkg-tests

This repository contains additional tests of the R package [workflowr][].

[workflowr]: https://github.com/workflowr/workflowr

## Weekly

The following tests are run every Monday:

* **current:** A current setup using the release versions

* **legacy:** A legacy setup using older versions

* **future:** A future setup using R-devel and many packages installed directly
from GitHub


Name    | OS           | R       | pandoc   | knitr   | rmarkdown | status
------- | ------------ | ------- | -------- | ------- | --------- | ------
current | Ubuntu 20.04 | release | 2.11.4   | release | release   | [![current](https://github.com/workflowr/workflowr-pkg-tests/workflows/current/badge.svg)](https://github.com/workflowr/workflowr-pkg-tests/actions/workflows/current.yaml)
legacy  | Ubuntu 18.04 | 3.3.3   | 1.19.2.4 | 1.29    | 1.18      | [![legacy](https://github.com/workflowr/workflowr-pkg-tests/workflows/legacy/badge.svg)](https://github.com/workflowr/workflowr-pkg-tests/actions/workflows/legacy.yaml)
future  | Ubuntu 20.04 | devel   | 2.16.2   | devel   | devel     | [![future](https://github.com/workflowr/workflowr-pkg-tests/workflows/future/badge.svg)](https://github.com/workflowr/workflowr-pkg-tests/actions/workflows/future.yaml)

## Quarterly

The following tests are run (at least) quarterly:

* **pandocless:** Runs `R CMD check --as-cran` in an environment without pandoc.
  Confirms that all tests that requires pandoc are properly skipped when it is
  unavailable (because some CRAN test machines don't have pandoc installed)
* **spell-check:** Checks spelling with `spelling::spell_check_package()`

Name        | status
----------- | -------
pandocless | [![pandocless](https://github.com/workflowr/workflowr-pkg-tests/workflows/pandocless/badge.svg)](https://github.com/workflowr/workflowr-pkg-tests/actions/workflows/pandocless.yaml)
spell-check | [![spell-check](https://github.com/workflowr/workflowr-pkg-tests/workflows/spell-check/badge.svg)](https://github.com/workflowr/workflowr-pkg-tests/actions/workflows/spell-check.yaml)

## Miscellaneous

Other tests available:

Name  | Purpose
------------- | -------------
reticulate    | Test `wflow_html()` warning for [Python plots created with reticulate version < 1.14.9000][workflowr181]
speed         | Test speed of `wflow_publish()` for dev version compared to previous versions

[workflowr181]: https://github.com/workflowr/workflowr/issues/181
