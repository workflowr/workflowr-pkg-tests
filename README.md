# workflowr-pkg-tests

[![CircleCI](https://circleci.com/gh/workflowr/workflowr-pkg-tests/tree/master.svg?style=svg)](https://circleci.com/gh/workflowr/workflowr-pkg-tests/tree/master)

This repository contains additional tests of the R package [workflowr][].


[workflowr]: https://github.com/jdblischak/workflowr

Name  | Purpose
------------- | -------------
future  | Catch future errors by installing development versions of dependencies
callr_3.3.0 | Run tests for handling callr 3.3.0 behavior (writing `data`/`env` to the global environment)
