#!/usr/bin/env Rscript

# Test conversion of git_time object to date
#
# Required packages: fs, git2r, testthat

library(testthat)

path <- fs::file_temp()
fs::dir_create(path)
r <- git2r::init(path)
git2r::config(r, user.name = "Test User", user.email = "testing")

f1 <- file.path(path, "f1.txt")
cat("line 1\n", file = f1)
git2r::add(r, f1)
c1 <- git2r::commit(r, "The first commit to f1")

# Info from git2r
unix_git2r <- c1$author$when$time
date_git2r <- as.character(as.Date(as.POSIXct(c1$author$when)))

# Info from Git
unix_git <- system(sprintf("git -C %s log -n 1 --date=unix --format=%%ad", path),
                   intern = TRUE)
unix_git <- as.numeric(unix_git)
date_git <- system(sprintf("git -C %s log -n 1 --date=short --format=%%ad", path),
                   intern = TRUE)

test_that("Git returns the correct date", {
  expect_identical(
    date_git,
    as.character(Sys.Date())
  )
})

test_that("Git and git2r return the same raw unix time", {
  expect_identical(
    unix_git2r,
    unix_git
  )
})

test_that("Git and git2r return the same human-readable date", {
  expect_identical(
    date_git2r,
    date_git
  )
})
