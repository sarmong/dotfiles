local configs = require("lsp.lspconfig")

local fns = {}

local formatting_fn

if vim.fn.has("nvim-0.8") == 1 then
  formatting_fn = vim.lsp.buf.format
else
  formatting_fn = function()
    vim.lsp.buf.formatting_sync(nil, 1000)
  end
end

fns.format = function()
  if vim.o.filetype == "org" then
    vim.cmd('exec "norm gg=G\\<C-o>"')
  else
    formatting_fn()
  end
  print("Formatted")
end

fns.enable_format_on_save = function()
  if not configs.settings.format_on_save then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("FormatOnSave", {}),
      callback = fns.format,
    })
    configs.settings.format_on_save = true

    print("Enabled formatting on save")
  end
end

fns.disable_format_on_save = function()
  if configs.settings.format_on_save then
    vim.api.nvim_del_augroup_by_name("FormatOnSave")
    configs.settings.format_on_save = false

    print("Disabled formatting on save")
  end
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

fns.disable_virtual_text = function()
  if vim.diagnostic.config().virtual_text then
    vim.diagnostic.config({ virtual_text = false })
    print("Virtual text off")
  end
end

-- taken from https://youtu.be/tAVxxdFFYMU
-- @TODO fix
fns.rename_with_quick_fix = function()
  local position_params = vim.lsp.util.make_position_params()
  local new_name = vim.fn.input("New Name > ")

  position_params.newName = new_name

  vim.lsp.buf_request(
    0,
    "textDocument/rename",
    position_params,
    function(err, method, result, ...)
      -- You can uncomment this to see what the result looks like.
      if false then
        print(vim.inspect(result))
      end
      vim.lsp.handlers["textDocument/rename"](err, method, result, ...)

      local entries = {}
      if result.changes then
        for uri, edits in pairs(result.changes) do
          local bufnr = vim.uri_to_bufnr(uri)

          for _, edit in ipairs(edits) do
            local start_line = edit.range.start.line + 1
            local line = vim.api.nvim_buf_get_lines(
              bufnr,
              start_line - 1,
              start_line,
              false
            )[1]

            table.insert(entries, {
              bufnr = bufnr,
              lnum = start_line,
              col = edit.range.start.character + 1,
              text = line,
            })
          end
        end
      end

      vim.fn.setqflist(entries, "r")
    end
  )
end

return fns
