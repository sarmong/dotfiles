local configs = req("lsp.lspconfig")

require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
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
  local ok, conf = pcall(require, "lsp.servers." .. server)
  if not ok then
    conf = {}
  end

  configs.setup(server, conf)
end

-- has to go after null_ls
require("mason-null-ls").setup({ automatic_installation = true })
