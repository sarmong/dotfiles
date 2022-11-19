local create_augroup = function(name, opts)
  opts = opts or {}
  vim.api.nvim_create_augroup(name, opts)
end

local create_autocmd = function(name, opts)
  vim.api.nvim_create_autocmd(name, opts)
end

-- Send WINdow CHanged signal to resize nvim properly when runnin alacritty -e nvim
create_autocmd("VimEnter", {
  group = create_augroup("WinCh"),
  command = 'silent exec "!kill -s SIGWINCH $PPID"',
})

create_autocmd({ "BufNewFile", "BufRead" }, {
  group = create_augroup("rasi_ft"),
  pattern = "*.rasi",
  command = "set syntax=css",
})

create_autocmd({ "BufNewFile", "BufRead" }, {
  group = create_augroup("md_ft"),
  pattern = "*.md",
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.textwidth = 80
  end,
})

create_autocmd("BufReadPost", {
  group = create_augroup("vim_startup"),
  pattern = "*",
  callback = function()
    vim.cmd([[
      if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
    ]])
  end,
})

-- Highlight on yank
create_autocmd("TextYankPost", {
  group = create_augroup("YankHighlight"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})
