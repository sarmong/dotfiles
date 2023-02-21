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

local on_init = function(client)
  local local_config_file
  local root_dir
  for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
    if vim.fn.filereadable(dir .. "/.nvim.lua") == 1 then
      root_dir = dir
      local_config_file = root_dir .. "/.nvim.lua"
      break
    end
  end
  if local_config_file then
    local local_config = dofile(local_config_file)
    local lsp_conf = local_config[client.name]
    if lsp_conf then
      for key, value in pairs(lsp_conf) do
        local maybe_path = root_dir .. "/" .. value
        if fn.filereadable(maybe_path) > 0 or fn.isdirectory(maybe_path) then
          value = maybe_path
        end
        client.config.settings[key] = value
      end
    end
  end
end

local default_config = {
  on_attach = on_attach,
  on_init = on_init,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  handlers = {
    ["textDocument/rename"] = fns.rename_qf,
  },
}

return default_config
