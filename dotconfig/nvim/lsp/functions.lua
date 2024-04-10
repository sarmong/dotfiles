local ts = req("typescript-tools.api")

local fns = {}

fns.format = function()
  local formatted = req("conform").format()
  if formatted then
    print("Formatted")
  else
    print("No formatting provider")
  end
end

fns.enable_format_on_save = function(silent)
  local config = req("lsp.config")
  config.format_on_save = true

  if not silent then
    print("Enabled formatting on save")
  end
end

fns.disable_format_on_save = function()
  local config = req("lsp.config")
  config.format_on_save = false
end

fns.go_to_type_definition = function()
  vim.lsp.buf.type_definition()
end

fns.rename = function()
  vim.lsp.buf.rename()
end

fns.code_action = function()
  vim.lsp.buf.code_action()
end

fns.open_float = function()
  vim.diagnostic.open_float()
end

fns.set_loc_list = function()
  vim.diagnostic.setloclist()
end

fns.enable_virtual_text = function()
  if not vim.diagnostic.config().virtual_text then
    vim.diagnostic.config({ virtual_text = true })
    print("Virtual text on")
  end
end

fns.disable_virtual_text = function(silent)
  if vim.diagnostic.config().virtual_text then
    vim.diagnostic.config({ virtual_text = false })

    if not silent then
      print("Virtual text off")
    end
  end
end

fns.toggle_virtual_text = function()
  if vim.diagnostic.config().virtual_text then
    fns.disable_virtual_text()
  else
    fns.enable_virtual_text()
  end
end

fns.go_to_source_definition = function()
  vim.cmd("TSToolsGoToSourceDefinition")
end

fns.rename_file = function()
  vim.cmd("TypescriptRenameFile")
end

fns.fix_all = ts.fix_all
fns.add_missing_imports = ts.add_missing_imports
fns.organize_imports = ts.organize_imports
fns.remove_unused = ts.remove_unused

fns.rename_qf = function(err, method, result, ...)
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

fns.peek_definition = function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(
    0,
    "textDocument/definition",
    params,
    function(_, result)
      if result == nil or vim.tbl_isempty(result) then
        return nil
      end
      vim.lsp.util.preview_location(result[1])
    end
  )
end

return fns
