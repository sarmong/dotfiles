require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })
require("mason-tool-installer").setup({
  ensure_installed = {
    "stylua",
    "shellcheck",
    "editorconfig-checker",
    "eslint_d",
    "prettierd",
    "stylelint-lsp",
    "shellcheck",
    "shfmt",
    "markdownlint",
  },
})

req("lsp.servers.ts")
req("lsp.servers.lua")
req("lsp.servers.css")
req("lsp.servers.bash")
req("lsp.servers.viml")
req("lsp.servers.python")
-- req("lsp.servers.remark")

req("lsp.servers.null-ls")
