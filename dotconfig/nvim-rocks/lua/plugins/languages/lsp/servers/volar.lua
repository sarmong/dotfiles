local helpers = req("plugins.languages.lsp.servers.helpers")

return {
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },

  root_dir = function(fname)
    return req("modules.root-dir").get_project_root()
  end,

  on_attach = function(client, bufnr)
    -- disable formatting, so that null-ls will handle it
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  autostart = helpers.isVueProject(),
}
