Plugin("williamboman/mason.nvim")
Plugin("williamboman/mason-lspconfig.nvim")
Plugin("WhoIsSethDaniel/mason-tool-installer.nvim")

req("mason-registry").refresh()
req("mason").setup()

local tools = req("plugins.ide.contrib").state.mason

req("mason-tool-installer").setup({ ensure_installed = tools })
req("mason-tool-installer").run_on_start()
