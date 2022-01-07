require("bqf").setup({
  auto_enable = true, -- enable nvim-bqf in quickfix window automatically
  magic_window = true, -- give the window magic, when the window is splited horizontally, keep the distance between the current line and the top/bottom border of neovim unchanged. It's a bit like a floating window, but the window is indeed a normal window, without any floating attributes
  auto_resize_height = true, -- resize quickfix window height automatically. Shrink higher height to size of list in quickfix window, otherwise extend height to size of list or to default height (10)
  preview = {
    auto_preview = true, -- enable preview in quickfix window automatically
    border_chars = {
      "│",
      "│",
      "─",
      "─",
      "╭",
      "╮",
      "╰",
      "╯",
      "█",
    }, -- border and scroll bar chars, they respectively represent: vline, vline, hline, hline, ulcorner, urcorner, blcorner, brcorner, sbar
    delay_syntax = 50, -- delay time, to do syntax for previewed buffer, unit is millisecond
    win_height = 15, -- the height of preview window for horizontal layout
    win_vheight = 15, -- the height of preview window for vertical layout
    wrap = false, -- wrap the line, `:h wrap` for detail
    should_preview_cb = nil, -- a callback function to decide whether to preview while switching buffer with a bufnr parameter
  },
})
