local null_ls = require("null-ls")
local lsp_fns = require("lsp.functions")
local configs = require("lsp.lspconfig")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.formatting.stylelint,
    -- null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.eslint.with({
      extra_args = { "-c", vim.fn.expand("~/.config/.eslintrc.json") },
      prefer_local = "node_modules/.bin",
    }),
    null_ls.builtins.code_actions.eslint.with({
      extra_args = { "-c", "~/.config/.eslintrc.json" },
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
  on_attach = function(client, bufnr)
    configs.default_opt.on_attach(client, bufnr)
    if
      client.resolved_capabilities.document_formatting
      and configs.format_on_save_enabled
    then
      lsp_fns.enable_format_on_save()
    end
    lsp_fns.disable_virtual_text()
  end,
})
