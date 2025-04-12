# Readme

Types:

- binary
- build
- deb
- appimage (wip)

## Base spec

- `name` - will be used for binary name
- `version`
- `type`
- `checksum`
- `url` - use `%%v%%` to be replaced by version
- `check_version_cmd` - will be checked against `version` field, can be a shell
  oneliner
- `post_install_task` - optional, tasks will be run after install. Can be used
  to copy/link some more files

## Build

- `dependencies` - list of packages to be installed with apt
- `build_cmd` - list of commands to run to build and install the program
- `extract_dir` - use if package archive doesn't contain a root directory. Use
  `%%v%%` to have separate dirs for each version
- `git_commit` - hack for packages installed from github zipped source. Done in
  order to separate from `version`. Since there may be no `--version` flag,
  `version` field can have shasum and `check_version_cmd` can run `sha256sum`.
