local lspconfig = req("lspconfig")
local default_config = req("lsp.servers.default")

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "astro",
  "bashls",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "eslint",
  "gopls",
  "htmx",
  "pylsp",
  "pyright",
  "lua_ls",
  "tsserver",
  "vimls",
  "volar",
}

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers })

req("lsp.servers.null_ls")
req("lsp.servers.metals")

for _, server in ipairs(servers) do
  local ok, server_config = pcall(require, "lsp.servers." .. server)

  -- if file loaded correctly and didn't return a table,
  -- no need to setup with lspconfig, server was already set up in a file
  if not ok or type(server_config) == "table" then
    local config =
      vim.tbl_deep_extend("force", default_config, ok and server_config or {})

    lspconfig[server].setup(
      vim.tbl_deep_extend("force", default_config, config)
    )
  end
end
