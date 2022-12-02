local create_augroup = function(name, opts)
  opts = opts or {}
  return vim.api.nvim_create_augroup(name, opts)
end

local create_autocmd = function(name, opts)
  if type(opts.group) == "string" then
    opts = vim.tbl_extend("force", opts, { group = create_augroup(opts.group) })
  end
  vim.api.nvim_create_autocmd(name, opts)
end

-- Send WINdow CHanged signal to resize nvim properly when runnin alacritty -e nvim
create_autocmd("VimEnter", {
  group = "Resize nvim on window resize",
  command = 'silent exec "!kill -s SIGWINCH $PPID"',
})

create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "rasi_ft",
  pattern = "*.rasi",
  command = "set syntax=css",
})

create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "Mardown options",
  pattern = "*.md",
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.textwidth = 80
  end,
})

create_autocmd("BufReadPost", {
  group = "Jump to the latest edit position",
  pattern = "*",
  callback = function()
    vim.cmd([[
      if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
    ]])
  end,
})

create_autocmd("TextYankPost", {
  group = "Highlight on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})
