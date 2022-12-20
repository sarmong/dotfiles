local lsp_fns = req("lsp.functions")

vim.diagnostic.config({
  float = { border = "rounded" },
  virtual_text = false,
})

lsp_fns.enable_format_on_save(true)

req("lsp.servers")
req("lsp.cmp")

req("fidget").setup({})
