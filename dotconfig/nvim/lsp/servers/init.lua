local lspconfig = req("lspconfig")
local configs = req("lsp.lspconfig")

require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
req("lsp.servers.ts")
req("lsp.servers.lua")
req("lsp.servers.null-ls")

local servers = {
  "bashls",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "pylsp",
  "pyright",
  "vimls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup(configs.default_opt)
end

-- has to go after null_ls
require("mason-null-ls").setup({ automatic_installation = true })
