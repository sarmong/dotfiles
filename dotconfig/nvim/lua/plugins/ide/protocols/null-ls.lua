if os.getenv("IS_SERVER") then
  return
end

Plugin("nvimtools/none-ls.nvim")

local null_ls = req("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup({
  -- sources = {
  --   -- null_ls.builtins.diagnostics.stylelint,
  --   -- null_ls.builtins.completion.spell,
  -- },
})

local setup_fns = req("plugins.ide.contrib").state.null_ls

for _, setup_source in ipairs(setup_fns) do
  setup_source()
end
