local null_ls = req("null-ls")
local default_conf = req("lsp.servers.default")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup({
  sources = {
    -- null_ls.builtins.diagnostics.stylelint,

    req("typescript.extensions.null-ls.code-actions"),

    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,

    null_ls.builtins.diagnostics.markdownlint.with({
      extra_args = { "--disable", "MD043" },
    }),

    -- null_ls.builtins.completion.spell,
  },
  on_attach = function(client, bufnr)
    default_conf.on_attach(client, bufnr)
  end,
})

-- has to go after null_ls
require("mason-null-ls").setup({ automatic_installation = true })
