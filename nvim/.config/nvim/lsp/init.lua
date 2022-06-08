local lsp_fns = req("lsp.functions")

lsp_fns.disable_virtual_text()
lsp_fns.enable_format_on_save()

req("lsp.servers")
req("lsp.cmp")
