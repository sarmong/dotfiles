local contrib = req("plugins.ide.contrib")

contrib.mason("lua-language-server", "stylua")
contrib.formatters("lua", "stylua")
contrib.ts_parsers("lua")

Plugin({ "sarmong/lazydev.nvim", checkout = "sarmong/require-aliases" })
Plugin("Bilal2453/luvit-meta")

req("lazydev").setup({
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
  integrations = {
    lspconfig = true,
    cmp = true,
  },
  enabled = function(root_dir)
    return vim.uv.fs_stat(root_dir .. "/deps-snap.lua")
      or vim.uv.fs_stat(root_dir .. "/pkg.json")
      or vim.uv.fs_stat(root_dir .. "/nvim-pack-lock.json")
  end,
})

contrib.lsp("lua_ls", function()
  return {
    on_attach = function(client, _bufnr)
      -- disable formatting, so that null-ls will handle it
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          vim.fn.resolve(path) == vim.fn.resolve(vim.fn.stdpath("config"))
          or vim.list_contains(
            vim.api.nvim_get_runtime_file("", true),
            vim.fn.resolve(path)
          )
        then
          client.config.settings.Lua =
            vim.tbl_deep_extend("force", client.config.settings.Lua, {
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
            })
        end
      end
    end,

    settings = {
      Lua = {
        diagnostics = {
          unusedLocalExclude = { "_*" },
        },
        telemetry = { enable = false },
        completion = { callSnippet = "Replace" },
      },
    },
  }
end)
