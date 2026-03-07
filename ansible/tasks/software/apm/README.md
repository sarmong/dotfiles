# Readme

Types:

- binary
- build
- git
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
- `version_file` - optional path to write `version` into after install. Useful
  when there's no `--version` flag; pair with `check_version_cmd: cat <path>`
- `post_install_task` - optional, tasks will be run after install. Can be used
  to copy/link some more files

## Build

- `dependencies` - list of packages to be installed with apt
- `build_cmds` - list of commands to run to build and install the program
- `extract_dir` - use if package archive doesn't contain a root directory. Use
  `%%v%%` to have separate dirs for each version

## Git

Clones a repo instead of downloading an archive. No `checksum` needed.

- `url` - git remote URL
- `version` - branch, tag, or commit ref to check out
- `extract_dir` - optional clone destination (defaults to `$XDG_SRC_DIR/<name>`)
- `build_cmds` - optional list of commands to run after cloning, same as Build
- `dependencies` - list of packages to be installed with apt
