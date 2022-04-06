local null_ls = require("null-ls")
local lsp_fns = require("lsp.functions")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.formatting.stylelint,
    -- null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
    null_ls.builtins.code_actions.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt.with({
      extra_args = { "-i", "2", "-ci" },
    }),

    null_ls.builtins.diagnostics.markdownlint,

    -- null_ls.builtins.completion.spell,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      lsp_fns.enable_format_on_save()
    end
  end,
})
