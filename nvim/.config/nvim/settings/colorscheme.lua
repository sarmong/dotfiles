vim.cmd("let g:nvcode_termcolors=256")

vim.cmd("colorscheme gruvbox")

vim.opt.background = "dark"

M = {}

M.toggle_background = function()
  print("called")
  print(vim.opt.background)
  if vim.o.background == "dark" then
    -- print(vim.opt.background)
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end
end

return M
