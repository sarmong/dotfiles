require("lsp.servers")

require("lsp.cmp")

local lsp_installer = require("nvim-lsp-installer")
local configs = require("lsp.lspconfig")
local lsp_fns = require("lsp.functions")

lsp_installer.on_server_ready(function(server)
  -- Use the server's custom settings, if they exist, otherwise default to the default options
  local server_options = configs.server_opt[server.name]
      and configs.server_opt[server.name]()
    or configs.default_opt
  server:setup(server_options)

  lsp_fns.disable_virtual_text()
end)
