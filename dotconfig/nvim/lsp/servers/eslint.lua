local default_conf = req("lsp.servers.default")

return {
  on_attach = function(client, bufnr)
    -- disable formatting, so that null-ls will handle it
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    default_conf.on_attach(client, bufnr)
  end,
}
