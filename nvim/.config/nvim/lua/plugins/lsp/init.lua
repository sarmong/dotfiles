require("plugins.lsp.ts")
require("plugins.lsp.lua")

require("plugins.lsp.cmp")
require("plugins.lsp.null-ls")

local lsp_installer = require("nvim-lsp-installer")
local configs = require("plugins.lsp.lspconfig")
local lsp_fns = require("plugins.lsp.functions")

lsp_installer.on_server_ready(function(server)
  -- Use the server's custom settings, if they exist, otherwise default to the default options
  local server_options = configs.server_opt[server.name]
      and configs.server_opt[server.name]()
    or configs.default_opt
  server:setup(server_options)

  lsp_fns.disable_virtual_text()
end)
