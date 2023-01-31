local capabilities = req("lsp.cmp")
local fns = req("lsp.functions")

local on_attach = function(client, bufnr, elses)
  local opts = { buffer = bufnr }

  if client.supports_method("textDocument/hover") then
    map("n", "K", vim.lsp.buf.hover, opts)
  end

  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "[d", vim.diagnostic.goto_prev, opts)
  map("n", "]d", vim.diagnostic.goto_next, opts)
end

local default_config = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  handlers = {
    ["textDocument/rename"] = fns.rename_qf,
  },
}

return default_config
