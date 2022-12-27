local capabilities = req("lsp.cmp")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr, elses)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  local function buf_set_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  if client.supports_method("textDocument/hover") then
    buf_set_keymap("n", "K", vim.lsp.buf.hover)
  end

  buf_set_keymap("n", "gD", vim.lsp.buf.declaration)
  buf_set_keymap("n", "gd", vim.lsp.buf.definition)
  buf_set_keymap("n", "gi", vim.lsp.buf.implementation)
  buf_set_keymap("n", "gr", vim.lsp.buf.references)
  buf_set_keymap("n", "[d", vim.diagnostic.goto_prev)
  buf_set_keymap("n", "]d", vim.diagnostic.goto_next)
end

local default_opt = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

local global_settings = {
  format_on_save = false,
}

return {
  default_opt = default_opt,
  server_opt = {},
  on_attach = on_attach,
  settings = global_settings,
}
