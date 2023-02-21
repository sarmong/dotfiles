local lspconfig = req("lspconfig")
local default_config = req("lsp.servers.default")

require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "null_ls",
  "bashls",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "eslint",
  "gopls",
  "pylsp",
  "pyright",
  "lua_ls",
  "tsserver",
  "vimls",
}

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

-- has to go after null_ls
require("mason-null-ls").setup({ automatic_installation = true })
