local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.deps",
    mini_path,
  }
  vim.system(clone_cmd):wait()
  vim.cmd("packadd mini.deps | helptags ALL")
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end
vim.opt.rtp:prepend(mini_path)

vim.g.mapleader = " "
require("mini.deps").setup({
  job = {
    -- n_threads = 100,
  },
  path = {
    package = path_package,
    snapshot = vim.fn.stdpath("config") .. "/deps-snap.lua",
  },
})
