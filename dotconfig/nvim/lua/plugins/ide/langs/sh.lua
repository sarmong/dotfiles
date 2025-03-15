local contrib = req("plugins.ide.contrib")

contrib.mason({ "bash-language-server", "shfmt", "shellcheck" })
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

-- So that lsp tools above don't run on it, also see after/syntax/dotenv.vim
vim.filetype.add({
  filename = {
    [".env"] = "dotenv",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
