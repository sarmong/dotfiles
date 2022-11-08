local lspconfig = req("lspconfig")

local configs = req("lsp.lspconfig")
local util = req("lspconfig.util")

lspconfig.tsserver.setup(vim.tbl_extend("force", configs.default_opt, {
  -- Prefer `.git` directory to avoid spawning new tsserver instance
  -- when going inside a package from node_modules
  root_dir = function(fname)
    return util.root_pattern(".git")(fname)
      or util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(
        fname
      )
  end,
  -- disable formatting with tsserver, so that null-ls will handle it
  on_attach = function(client, bufnr)
    configs.default_opt.on_attach(client, bufnr)

    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  single_file_support = true,
}))
