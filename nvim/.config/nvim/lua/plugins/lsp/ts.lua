local lspconfig = require('lspconfig')
local default_config = require('plugins.lsp.lspconfig')

lspconfig.tsserver.setup {
    on_attach = default_config.on_attach,
    flags = default_config.flags
}
