local functions = require("lsp.functions")
local default_conf = req("lsp.servers.default")
local util = req("lspconfig.util")

req("typescript").setup({
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = false, -- fall back to standard LSP definition on failure
  },
  server = vim.tbl_extend("force", default_conf, {
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

      default_conf.on_attach(client, bufnr)

      -- go_to_source_definition doesn't list .d.ts files
      map("n", "gd", functions.go_to_source_definition, { buffer = bufnr })
    end,

    single_file_support = true,
  }),
})
