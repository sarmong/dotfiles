require("lsp.servers")

require("lsp.cmp")

local lsp_installer = require("nvim-lsp-installer")
local configs = require("lsp.lspconfig")
local lsp_fns = require("lsp.functions")

lsp_installer.on_server_ready(function(server)
  local server_options = vim.tbl_extend(
    "force",
    configs.default_opt,
    configs.server_opt[server.name] or {}
  )
  server:setup(server_options)

  lsp_fns.disable_virtual_text()
end)
