local lspconfig = require("lspconfig")

local configs = require("lsp.lspconfig")

lspconfig.vimls.setup(configs.default_opt)
