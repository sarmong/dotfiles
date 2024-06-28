local contrib = req("plugins.ide.contrib")

contrib.mason({ "bashls", "shfmt" })
contrib.formatters("sh", "shfmt")
contrib.ts_parsers("bash")
contrib.lsp("bashls")
contrib.null_ls_sources(function()
  Plugin("gbprod/none-ls-shellcheck.nvim")

  req("null-ls").register(req("none-ls-shellcheck.diagnostics"))
  req("null-ls").register(req("none-ls-shellcheck.code_actions"))
end)

-- Use bash treesitter for zsh filetypes
vim.treesitter.language.register("bash", "zsh")
