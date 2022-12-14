local configs = req("lsp.lspconfig")
local util = req("lspconfig.util")

req("typescript").setup({
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = vim.tbl_extend("force", configs.default_opt, {
    -- Prefer `.git` directory to avoid spawning new tsserver instance
    -- when going inside a package from node_modules
    root_dir = function(fname)
      return util.root_pattern(".git")(fname)
        or util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(
          fname
        )
    end,
    on_attach = function(client, bufnr)
      -- disable formatting with tsserver, so that null-ls will handle it
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      configs.default_opt.on_attach(client, bufnr)
    end,

    single_file_support = true,
  }),
})
