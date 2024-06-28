local rename_with_qf = function(err, method, result, ...)
  vim.lsp.handlers["textDocument/rename"](err, method, result, ...)
  local changes = method.changes or method.documentChanges

  if not changes or vim.tbl_count(changes) < 2 then
    return
  end

  local entries = {}
  for uri, edits in pairs(changes) do
    local bufnr = vim.uri_to_bufnr(uri)

    for _, edit in ipairs(edits) do
      local start_line = edit.range.start.line + 1
      local line =
        vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]

      table.insert(entries, {
        bufnr = bufnr,
        lnum = start_line,
        col = edit.range.start.character + 1,
        text = line,
      })
    end
  end

  vim.fn.setqflist(entries, " ")
  vim.cmd.copen()
end

local on_attach = function(client, bufnr)
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

local get_default_lsp_config = function()
  return {
    on_attach = on_attach,
    -- on_init = on_init,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = req("cmp_nvim_lsp").default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    handlers = {
      ["textDocument/rename"] = rename_with_qf,
    },
  }
end

local function isVueProject()
  local matches =
    vim.fs.find("App.vue", { type = "file", limit = 1, path = "src" })
  return #matches >= 1
end

return {
  get_default_lsp_config = get_default_lsp_config,
  isVueProject = isVueProject,
}
