vim.loader.enable()
local config_dir = vim.api.nvim_eval("stdpath('config')")
package.path = config_dir
  .. "/?.lua;"
  .. config_dir
  .. "/?/init.lua;"
  .. package.path

require("utils")

req("deps")
req("settings")

-- vim.cmd("source " .. config_dir .. "/utils/quitdialog.vim")