local configs = require("lsp.lspconfig")
local lsp_install = require("lsp.lsp-install")

lsp_install("tsserver")

configs.server_opt["tsserver"] = {
  -- disable formatting with tsserver, so that null-ls will handle it
  on_attach = function(client, bufnr)
    configs.default_opt.on_attach(client, bufnr)

    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,

  single_file_support = true,
}
