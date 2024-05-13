if os.getenv("IS_SERVER") then
  return
end

Plugin("nvimtools/none-ls.nvim")
Plugin("gbprod/none-ls-shellcheck.nvim")

local null_ls = req("null-ls")
local default_conf = req("plugins.languages.lsp.servers.default")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup({
  sources = {
    -- null_ls.builtins.diagnostics.stylelint,

    req("none-ls-shellcheck.diagnostics"),
    req("none-ls-shellcheck.code_actions"),

    -- null_ls.builtins.diagnostics.markdownlint.with({
    --   extra_args = { "--disable", "MD043" },
    -- }),

    -- null_ls.builtins.completion.spell,
  },
  on_attach = function(client, bufnr)
    default_conf.on_attach(client, bufnr)
  end,
})
