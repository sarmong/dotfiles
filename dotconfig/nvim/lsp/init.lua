local lsp_fns = req("lsp.functions")

req("lsp.servers")
req("lsp.cmp")

req("fidget").setup({})

lsp_fns.enable_format_on_save(true)

vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
  severity_sort = true,
  virtual_text = false,
})

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
