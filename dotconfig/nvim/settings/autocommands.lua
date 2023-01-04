-- Send WINdow CHanged signal to resize nvim properly when runnin alacritty -e nvim
autocmd("VimEnter", {
  group = "Resize nvim on window resize",
  command = 'silent exec "!kill -s SIGWINCH $PPID"',
})

autocmd({ "BufNewFile", "BufRead" }, {
  group = "rasi_ft",
  pattern = "*.rasi",
  command = "set syntax=css",
})

autocmd({ "BufNewFile", "BufRead" }, {
  group = "Mardown options",
  pattern = "*.md",
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.textwidth = 80
  end,
})

-- autocmd("BufReadPost", {
--   group = "Jump to the latest edit position",
--   pattern = "*",
--   callback = function()
--     vim.cmd([[
--       if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
--       \ |   exe "normal! g`\""
--       \ | endif
--     ]])
--   end,
-- })

autocmd("TextYankPost", {
  group = "Highlight on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("BufWritePre", {
  group = "Remove trailing spaces",
  pattern = { "*.conf", "sxhkdrc", "lfrc", "*/newsboat/config", "*.rasi" },
  callback = function()
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[ %s/\s\+$//e ]])
    vim.api.nvim_win_set_cursor(0, cur)
  end,
})
