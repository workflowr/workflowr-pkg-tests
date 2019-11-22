#!/usr/bin/env Rscript

# Test the speed of wflow_publish()

library(workflowr)
path <- fs::file_temp()

message("\nwflow_start()")
system.time(
  start <- wflow_start(path, change_wd = FALSE, user.name = "Test",
                       user.email = "test@test.com")
)

# Create a workflowr project with lots of R Markdown files in various states
r <- git2r::repository(path)
scratch <- fs::path(path, "analysis", glue::glue("scratch-{1:100}.Rmd"))
fs::file_create(scratch)
published <- fs::path(path, "analysis", glue::glue("published-{1:100}.Rmd"))
fs::file_create(published)
git2r::add(r, published)
git2r::commit(r, "Commit Rmd files to be published")
published_html <- fs::path(path, "docs", glue::glue("published-{1:100}.html"))
fs::file_create(published_html)
git2r::add(r, published_html)
git2r::commit(r, "Commit html files")
unpublished <- fs::path(path, "analysis", glue::glue("unpublished-{1:100}.Rmd"))
fs::file_create(unpublished)
git2r::add(r, unpublished)
git2r::commit(r, "Commit Rmd files to be unpublished")

# These files will be edited and committed many times to generate many commits
rmd <- fs::path(path, "analysis", c("index.Rmd", "about.Rmd", "license.Rmd"))

for (i in 1:500) {
  tmp <- lapply(rmd, function(x) cat("\nedit\n", file = x, append = TRUE))
  git2r::add(r, rmd)
  git2r::commit(r, glue::glue("commit {i}"))
}

tmp <- lapply(rmd, function(x) cat("\nedit\n", file = x, append = TRUE))

message("\nwflow_publish()")
system.time(
  suppressMessages(
    publish <- wflow_publish(rmd, "commit message", view = FALSE, project = path)
  )
)

message("\nwflow_status()")
# Do some proper bench marking
bench_status <- bench::mark(wflow_status(project = path), iterations = 5)
summary(bench_status, filter_gc = FALSE)[, c("min", "median", "mem_alloc", "n_itr", "n_gc")]
