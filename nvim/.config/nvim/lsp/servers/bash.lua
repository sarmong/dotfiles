local lspconfig = req("lspconfig")

local configs = req("lsp.lspconfig")

lspconfig.bashls.setup(configs.default_opt)
