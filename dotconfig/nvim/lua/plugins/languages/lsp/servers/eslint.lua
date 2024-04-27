local util = req("lspconfig.util")

return {
  root_dir = function(fname)
    return util.root_pattern(
      "package-lock.json",
      "yarn.lock",
      ".git",
      "package.json",
      "tsconfig.json",
      "jsconfig.json"
    )(fname)
  end,
  on_attach = function(client, bufnr)
    -- disable formatting, so that null-ls will handle it
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
