vim.cmd("let g:nvcode_termcolors=256")

pcall(vim.cmd, "colorscheme gruvbox-material")
-- pcall(vim.cmd, "colorscheme catpuccin-latte")

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

pcall(require, "settings.colorscheme.current")

autocmd("Signal", {
  group = "Update colorscheme",
  pattern = "SIGUSR1",
  callback = function()
    package.loaded["settings.colorscheme.current"] = nil
    pcall(require, "settings.colorscheme.current")
    req("lualine").setup(req("lualine").get_config())
  end,
})

return M
