local helpers = req("plugins-new.languages.lsp.servers.helpers")

return {
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },

  on_attach = function(client, bufnr)
    -- disable formatting, so that null-ls will handle it
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  autostart = helpers.isVueProject(),
}
