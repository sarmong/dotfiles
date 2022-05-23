local configs = require("lsp.lspconfig")
local lsp_install = require("lsp.lsp-install")

lsp_install("tsserver")

configs.server_opt["tsserver"] = {
  -- disable formatting with tsserver, so that null-ls will handle it
  on_attach = function(client, bufnr)
    configs.default_opt.on_attach(client, bufnr)

    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  single_file_support = true,
}
