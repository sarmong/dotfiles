local config_dir = vim.api.nvim_eval("stdpath('config')")
package.path = config_dir
  .. "/?.lua;"
  .. config_dir
  .. "/?/init.lua;"
  .. package.path

require("utils.packer-bootstrap")

require("settings")
require("plugins")
require("lsp")
