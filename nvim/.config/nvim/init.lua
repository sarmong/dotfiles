local config_dir = vim.api.nvim_eval("stdpath('config')")
package.path = config_dir
  .. "/?.lua;"
  .. config_dir
  .. "/?/init.lua;"
  .. package.path

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

require("settings")
require("plugins")
require("lsp")
