local function print_output(buf, command)
  local append_data = function(_, data)
    if data then
      a.nvim_buf_set_lines(buf, -1, -1, false, data)
    end
  end

  a.nvim_buf_set_lines(buf, 0, -1, false, { "File output:", "" })

  fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data,
  })
end

local function get_command(file)
  return ({
    sh = { file },
    lua = { "lua", file },
    javascript = { "node", file },
    typescript = { "ts-node", "-T", file },
    go = { "go", "run", file },
    python = { "python", file },
  })[vim.bo.filetype]
end

local function run_file()
  local current_buf = a.nvim_get_current_buf()
  local current_win = a.nvim_get_current_win()
  local filepath = fn.expand("%:p")

  local command = get_command(filepath)
  if not command then
    return
  end

  local output_buf = a.nvim_create_buf(false, true)
  cmd("65vsplit")
  a.nvim_set_current_buf(output_buf)
  local output_win = a.nvim_get_current_win()

  map("n", "q", ":q<CR>", { buffer = output_buf })
  a.nvim_set_current_win(current_win)

  print_output(output_buf, command)

  local autocmd_id = autocmd("BufWritePost", {
    group = "Run on Save",
    buffer = current_buf,
    callback = function()
      print_output(output_buf, command)
    end,
  })

  autocmd("WinClosed", {
    group = "Remove Run on Save",
    pattern = tostring(output_win),
    once = true,
    callback = function()
      a.nvim_del_autocmd(autocmd_id)
    end,
  })
end

return run_file
