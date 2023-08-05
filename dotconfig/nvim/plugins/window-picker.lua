req("window-picker").setup({
  autoselect_one = true,
  include_current_win = true,
  highlights = {
    statusline = {
      focused = {
        bg = "#076678",
      },
      unfocused = {
        bg = "#076678",
      },
    },
    winbar = {
      focused = { bg = "#076678" },
      unfocused = {
        bg = "#076678",
      },
    },
  },
  filter_rules = {
    bo = {
      filetype = { "NvimTree", "neo-tree", "notify", "qf" },
      buftype = { "terminal" },
    },
  },
})

command("Pick", function(e)
  local picked = req("window-picker").pick_window()
  vim.api.nvim_set_current_win(picked)
  vim.cmd("e " .. e.fargs[1])
end, { nargs = "?", complete = "file" })
