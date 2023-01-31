local lspconfig = req("lspconfig")

local default_config = req("lsp.servers.default")

require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- @TODO
req("lsp.servers.tsserver")
req("lsp.servers.null-ls")

local servers = {
  "bashls",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "pylsp",
  "pyright",
  "sumneko_lua",
  "vimls",
  "gopls",
}

for _, server in ipairs(servers) do
  local ok, config = pcall(require, "lsp.servers." .. server)
  if not ok then
    config = {}
  end

  lspconfig[server].setup(vim.tbl_deep_extend("force", default_config, config))
end

-- has to go after null_ls
require("mason-null-ls").setup({ automatic_installation = true })
