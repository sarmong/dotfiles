local function extractNames(tbl)
  local names = {}
  for _, source in ipairs(tbl) do
    table.insert(names, source.name)
  end
  return names
end

return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    cond = not os.getenv("IS_SERVER"),
    dependencies = { "gbprod/none-ls-shellcheck.nvim" },

    config = function()
      local null_ls = req("null-ls")
      local default_conf = req("plugins.languages.lsp.servers.default")

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
      null_ls.setup({
        sources = {
          -- null_ls.builtins.diagnostics.stylelint,

          req("none-ls-shellcheck.diagnostics"),
          req("none-ls-shellcheck.code_actions"),

          null_ls.builtins.diagnostics.markdownlint.with({
            extra_args = { "--disable", "MD043" },
          }),

          -- null_ls.builtins.completion.spell,
        },
        on_attach = function(client, bufnr)
          default_conf.on_attach(client, bufnr)
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.tools = opts.tools or {}
      vim.list_extend(opts.tools, extractNames(req("null-ls").get_sources()))
    end,
  },
}
