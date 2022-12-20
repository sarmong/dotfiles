req("window-picker").setup({
  autoselect_one = true,
  include_current_win = true,
  current_win_hl_color = "#89b4fa",
  other_win_hl_color = "#89b4fa",
})

vim.api.nvim_create_user_command("Pick", function(e)
  local picked = req("window-picker").pick_window()
  vim.api.nvim_set_current_win(picked)
  vim.cmd("e " .. e.fargs[1])
end, { nargs = "?", complete = "file" })
