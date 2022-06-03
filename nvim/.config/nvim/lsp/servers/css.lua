local lspconfig = require("lspconfig")

local configs = require("lsp.lspconfig")

lspconfig.cssls.setup(configs.default_opt)
lspconfig.cssmodules_ls.setup(configs.default_opt)
