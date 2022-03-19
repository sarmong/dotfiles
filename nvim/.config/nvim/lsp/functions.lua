local fns = {}

fns.format = function()
  vim.lsp.buf.formatting_sync(nil, 1000)
  print("Formatted")
end

fns.enable_format_on_save = function()
  -- disable format on save to not have doubles
  -- @TODO - wrap in augroup
  vim.cmd("autocmd! BufWritePre <buffer>")
  vim.cmd("autocmd BufWritePre <buffer> lua require('lsp.functions').format()")
  print("Enabled formatting on save")
end

fns.disable_format_on_save = function()
  -- @TODO - this might disable all autocommands, beware
  vim.cmd("autocmd! BufWritePre <buffer>")
  print("Disabled formatting on save")
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
  vim.diagnostic.setlocklist()
end

fns.enable_virtual_text = function()
  vim.diagnostic.config({ virtual_text = true })
  print("Virtual text on")
end

fns.disable_virtual_text = function()
  vim.diagnostic.config({ virtual_text = false })
  print("Virtual text off")
end

return fns
