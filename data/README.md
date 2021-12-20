The file `legacy-package-versions.csv` is used by
`.github/workflows/legacy.yaml` to install legacy versions of workflowr's
dependencies. This prevents random breaks as package updates drop support for R
3.3. The file is created by `scripts/download-legacy-versions.R`, and the file
`scripts/install-legacy-versions.R` actually installs the package during the
build.
