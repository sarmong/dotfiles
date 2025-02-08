vim.loader.enable()
local config_dir = vim.api.nvim_eval("stdpath('config')")
package.path = config_dir
  .. "/?.lua;"
  .. config_dir
  .. "/?/init.lua;"
  .. package.path

_G.lean_mode = os.getenv("NVIM_LEAN") or os.getenv("IS_SERVER")

require("utils")

req("user-prefs")
req("deps")
req("plugins")
req("settings")

req("modules.clipboard")
req("modules.sessions")
req("modules.save-win-view")
req("modules.terminal")

-- vim.cmd("source " .. config_dir .. "/utils/quitdialog.vim")
