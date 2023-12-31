vim.diagnostic.config({
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
  severity_sort = true,
  virtual_text = false,
})

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

local global_settings = {
  format_on_save = true,
}

return global_settings
