local config_dir = vim.api.nvim_eval("stdpath('config')")
package.path = config_dir
  .. "/?.lua;"
  .. config_dir
  .. "/?/init.lua;"
  .. package.path

IDE = not os.getenv("IS_SERVER")

require("utils")

req("plugins-lazy")
req("plugins")
req("settings")

if IDE then
  req("lsp")
end

-- vim.cmd("source " .. config_dir .. "/utils/quitdialog.vim")
