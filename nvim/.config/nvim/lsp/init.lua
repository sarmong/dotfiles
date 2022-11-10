local lsp_fns = req("lsp.functions")

lsp_fns.disable_virtual_text(true)
lsp_fns.enable_format_on_save(true)

req("lsp.servers")
req("lsp.cmp")

req("fidget").setup({})
