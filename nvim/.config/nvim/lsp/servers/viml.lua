local lspconfig = req("lspconfig")

local configs = req("lsp.lspconfig")

lspconfig.vimls.setup(configs.default_opt)
