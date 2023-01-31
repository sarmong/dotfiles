local lsp_fns = req("lsp.functions")

req("lsp.servers")
req("lsp.cmp")
req("lsp.config")

req("fidget").setup({})

lsp_fns.enable_format_on_save(true)
