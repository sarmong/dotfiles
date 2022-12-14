local lspconfig = req("lspconfig")

local configs = req("lsp.lspconfig")

lspconfig.cssls.setup(configs.default_opt)
lspconfig.cssmodules_ls.setup(configs.default_opt)
