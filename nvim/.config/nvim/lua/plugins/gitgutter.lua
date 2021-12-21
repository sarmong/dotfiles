vim.api.nvim_set_var("gitgutter_map_keys", 0)

vim.api.nvim_set_var("gitgutter_grep", "rg")

vim.api.nvim_set_keymap("n", "]h", "<Plug>(GitGutterNextHunk)", {})
vim.api.nvim_set_keymap("n", "[h", "<Plug>(GitGutterPrevHunk)", {})

vim.cmd("au BufEnter * :GitGutterLineNrHighlightsEnable")
