# workflowr-pkg-tests

[![CircleCI](https://circleci.com/gh/workflowr/workflowr-pkg-tests/tree/main.svg?style=svg)](https://circleci.com/gh/workflowr/workflowr-pkg-tests/tree/main)

This repository contains additional tests of the R package [workflowr][].


[workflowr]: https://github.com/jdblischak/workflowr

Name  | Purpose
------------- | -------------
future        | Catch future errors by installing development versions of dependencies
reticulate    | Test `wflow_html()` warning for [Python plots created with reticulate version < 1.14.9000][workflowr181]
speed         | Test speed of `wflow_publish()` for dev version compared to previous versions

[workflowr181]: https://github.com/jdblischak/workflowr/issues/181

Name    | OS           | R       | pandoc   | knitr   | rmarkdown | status
------- | ------------ | ------- | -------- | ------- | --------- | ------
current | Ubuntu 20.04 | release | 2.7.3    | release | release   | [![current](https://github.com/workflowr/workflowr-pkg-tests/workflows/current/badge.svg)](https://github.com/workflowr/workflowr-pkg-tests/actions/workflows/current.yaml)
legacy  | Ubuntu 18.04 | 3.3.3   | 1.19.2.4 | 1.29    | 1.18      | [![legacy](https://github.com/workflowr/workflowr-pkg-tests/workflows/legacy/badge.svg)](https://github.com/workflowr/workflowr-pkg-tests/actions/workflows/legacy.yaml)
