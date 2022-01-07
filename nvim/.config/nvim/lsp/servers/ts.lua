local configs = require("lsp.lspconfig")
local lsp_install = require("lsp.lsp-install")

lsp_install("tsserver")

configs.server_opt["tsserver"] = function()
  -- disable formatting with tsserver, so that null-ls will handle it
  configs.default_opt.on_attach = function(client)
    configs.on_attach()
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  configs.default_opt.single_file_support = true
end
