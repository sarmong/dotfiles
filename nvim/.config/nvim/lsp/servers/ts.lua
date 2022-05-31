local configs = require("lsp.lspconfig")
local lsp_install = require("lsp.lsp-install")

lsp_install("tsserver")

configs.server_opt["tsserver"] = {
  -- disable formatting with tsserver, so that null-ls will handle it
  on_attach = function(client, bufnr)
    configs.default_opt.on_attach(client, bufnr)

    if vim.fn.has("nvim-0.8") == 1 then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    else
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end,

  single_file_support = true,
}
