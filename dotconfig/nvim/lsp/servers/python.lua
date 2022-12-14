local lspconfig = req("lspconfig")

local configs = req("lsp.lspconfig")

lspconfig.pylsp.setup(configs.default_opt)
lspconfig.pyright.setup(configs.default_opt)
