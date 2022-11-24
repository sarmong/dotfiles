require("project_nvim").setup({
  detection_methods = { "pattern", "lsp" },
  -- for packages inside monorepo
  patterns = {
    "package.json",
    ".git",
  },
  show_hidden = true,
})
