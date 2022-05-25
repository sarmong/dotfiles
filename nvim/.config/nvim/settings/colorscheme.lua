vim.cmd("let g:nvcode_termcolors=256")

vim.cmd("colorscheme gruvbox")

vim.opt.background = "dark"

M = {}

M.toggle_background = function()
  if vim.o.background == "dark" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end
end

return M
