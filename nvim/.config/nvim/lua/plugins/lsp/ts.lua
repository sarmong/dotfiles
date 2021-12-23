local configs = require("plugins.lsp.lspconfig")
local lsp_install = require("plugins.lsp.lsp-install")

lsp_install("tsserver")

configs.server_opt["tsserver"] = function()
  -- disable formatting with tsserver, so that null-ls will handle it
  configs.default_opt.on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end
