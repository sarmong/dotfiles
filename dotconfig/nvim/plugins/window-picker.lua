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
      filetype = {
        "NvimTree",
        "neo-tree",
        "neo-tree-popup",
        "notify",
        "qf",
        "scratch",
      },
      buftype = { "terminal", "quickfix" },
    },
  },
})

local function pick(file)
  local picked = req("window-picker").pick_window()
  if not picked then
    return
  end
  a.nvim_set_current_win(picked)
  cmd("e " .. file)
end

command("Pick", function(e)
  pick(e.fargs[1])
end, { nargs = "?", complete = "file" })

return {
  pick = pick,
}
