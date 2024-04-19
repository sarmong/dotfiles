local function get_visual_selection()
  -- Yank current visual selection into the 'v' register
  -- Note that this makes no effort to preserve this register
  -- vim.cmd('noau normal! "vy"')
  -- vim.print(vim.fn.getreg("v"))

  local sel_start = vim.fn.getpos("'<")
  local sel_end = vim.fn.getpos("'>")
  local start_line = sel_start[2] - 1
  local start_col = sel_start[3] - 1
  local end_line = sel_end[2] - 1
  local end_col = sel_end[3]

  local lines =
    vim.api.nvim_buf_get_text(0, start_line, start_col, end_line, end_col, {})
  return lines[1]
end

return get_visual_selection
