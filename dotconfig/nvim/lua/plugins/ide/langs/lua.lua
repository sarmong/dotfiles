local contrib = req("plugins.ide.contrib")

contrib.mason({ "lua_ls", "stylua" })
contrib.formatters("lua", "stylua")
contrib.ts_parsers("lua")

Plugin("folke/lazydev.nvim")
Plugin("Bilal2453/luvit-meta")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, "?/init.lua")

local library = vim.api.nvim_get_runtime_file("", true)
table.insert(library, "/usr/share/nvim/runtime/lua")
table.insert(library, "/usr/share/nvim/runtime/lua/lsp")
table.insert(library, "/usr/share/awesome/lib")

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
      or vim.uv.fs_stat(root_dir .. "/init.lua")
  end,
})

contrib.lsp("lua_ls", function()
  return {
    on_attach = function(client, bufnr)
      -- disable formatting with sumneko_lua, so that null-ls will handle it
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,

    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          -- path = runtime_path,
          special = {
            req = "require",
          },
        },
        diagnostics = {
          enable = true,
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "use", "awesome", "client", "root" },
        },
        -- workspace = {
        --   -- Make the server aware of Neovim runtime files
        --   library = library,
        -- },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  }
end)
