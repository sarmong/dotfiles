local null_ls = req("null-ls")
local default_conf = req("lsp.servers.default")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.formatting.prettierd.with({
      extra_args = { "--prose-wrap=always" },
    }),

    -- null_ls.builtins.formatting.stylelint,
    -- null_ls.builtins.diagnostics.stylelint,

    req("typescript.extensions.null-ls.code-actions"),

    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.eslint_d.with({
      -- extra_args = { "-c", vim.fn.expand("~/.config/.eslintrc.json") },
      prefer_local = "node_modules/.bin",
    }),
    null_ls.builtins.code_actions.eslint_d.with({
      -- extra_args = { "-c", "~/.config/.eslintrc.json" },
      prefer_local = "node_modules/.bin",
    }),

    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt.with({
      extra_args = { "--indent", "2", "--case-indent" }, -- space-redirects ?
    }),

    null_ls.builtins.diagnostics.markdownlint.with({
      extra_args = { "--disable", "MD043" },
    }),
    null_ls.builtins.formatting.markdownlint,

    -- null_ls.builtins.completion.spell,
  },
  on_attach = function(client, bufnr)
    default_conf.on_attach(client, bufnr)
  end,
})