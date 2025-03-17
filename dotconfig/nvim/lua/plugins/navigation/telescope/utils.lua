local actions = lreq("telescope.actions")
local action_state = lreq("telescope.actions.state")
local action_set = lreq("telescope.actions.set")
local all_recent = lreq("telescope-all-recent")

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

  local last_file = filenames:rpeek()

  filenames:each(function(file)
    vim.cmd.badd(file)

    local entry = action_state.get_selected_entry()
    if type(entry) == "table" then
      all_recent.on_entry_confirm(entry.ordinal)
    end
  end)

  actions.close(prompt_bufnr) -- needs to be after all-recents saves item
  vim.cmd.edit(last_file)
end

local function pick_window_and_edit(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if type(entry) == "table" then
    all_recent.on_entry_confirm(entry.ordinal)
  end

  action_set.edit(prompt_bufnr, "Pick")
end

return {
  multi_select = multi_select,
  pick_window_and_edit = pick_window_and_edit,
}
