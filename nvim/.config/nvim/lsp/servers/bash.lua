local lspconfig = require("lspconfig")

local configs = require("lsp.lspconfig")

lspconfig.bashls.setup(configs.default_opt)
