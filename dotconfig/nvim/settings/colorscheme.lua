vim.cmd("let g:nvcode_termcolors=256")

pcall(vim.cmd, "colorscheme gruvbox-material")

vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_background = "medium"

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
