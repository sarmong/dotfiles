local _, ok = req("settings.colorscheme.current")
if not ok then
  pcall(vim.cmd.colorscheme, "gruvbox-material")
end

vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_enable_italic = 1

vim.opt.background = "dark"

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
    package.loaded["settings.colorscheme.current"] = nil
    pcall(require, "settings.colorscheme.current")
    req("lualine").setup(req("lualine").get_config())
  end,
})

return M
