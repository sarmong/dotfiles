local actions = lreq("telescope.actions")
local action_state = lreq("telescope.actions.state")
local action_set = lreq("telescope.actions.set")

-- TODO: doesn't work for live_grep and _args
local function multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi_selection = picker:get_multi_selection()

  if vim.tbl_isempty(multi_selection) then
    actions.select_default(prompt_bufnr)
    return
  end

  local filenames = vim.iter(multi_selection):map(function(v)
    -- live_grep stores filename in filename and find_files in [1]
    return v.filename and v.filename or v[1]
  end)

  actions.close(prompt_bufnr)

  vim.cmd.edit(filenames:rpeek())

  filenames:each(function(file)
    vim.cmd.badd(file)
  end)
end

local function pick_window_and_edit(prompt_bufnr)
  action_set.edit(prompt_bufnr, "Pick")
end

return {
  multi_select = multi_select,
  pick_window_and_edit = pick_window_and_edit,
}
