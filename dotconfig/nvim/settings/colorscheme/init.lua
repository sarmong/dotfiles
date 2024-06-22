pcall(vim.cmd.colorscheme, Pref.ui.colorscheme)
vim.opt.background = Pref.ui.background()

vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_enable_italic = 1

M = {}

M.toggle_background = function()
  if vim.o.background == "dark" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end
end

autocmd("Signal", {
  group = "Update colorscheme",
  pattern = "SIGUSR1",
  callback = function()
    vim.opt.background = Pref.ui.background()
    pcall(vim.cmd.colorscheme, Pref.ui.colorscheme)
    req("lualine").setup(req("lualine").get_config())
  end,
})

return M
