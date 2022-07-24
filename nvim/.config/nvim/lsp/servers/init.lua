local lsp_installer = req("nvim-lsp-installer")

lsp_installer.setup({ automatic_installation = true })

req("lsp.servers.ts")
req("lsp.servers.lua")
req("lsp.servers.css")
req("lsp.servers.bash")
req("lsp.servers.viml")
req("lsp.servers.python")
-- req("lsp.servers.remark")

req("lsp.servers.null-ls")
