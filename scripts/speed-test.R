#!/usr/bin/env Rscript

# Test the speed of wflow_publish()

library(workflowr)
path <- fs::file_temp()
wflow_start(path, change_wd = FALSE, user.name = "Test",
            user.email = "test@test.com")
rmd <- fs::dir_ls(fs::path(path, "analysis"), glob = "*Rmd")
for (i in 1:100) {
  tmp <- lapply(rmd, function(x) cat("\nedit\n", file = x, append = TRUE))
  wflow_git_commit(rmd, project = path)
}
tmp <- lapply(rmd, function(x) cat("\nedit\n", file = x, append = TRUE))
system.time(publish <- wflow_publish(rmd, "commit message", view = FALSE, project = path))
