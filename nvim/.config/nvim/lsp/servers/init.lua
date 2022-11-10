require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

req("lsp.servers.ts")
req("lsp.servers.lua")
req("lsp.servers.css")
req("lsp.servers.bash")
req("lsp.servers.viml")
req("lsp.servers.python")
-- req("lsp.servers.remark")

req("lsp.servers.null-ls")

-- has to go after null_ls
require("mason-null-ls").setup({ automatic_installation = true })
