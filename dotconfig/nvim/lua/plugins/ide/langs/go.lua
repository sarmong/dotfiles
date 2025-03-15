local contrib = req("plugins.ide.contrib")

contrib.mason("gopls")
contrib.ts_parsers("go", "gotmpl")

contrib.lsp("gopls", function()
  return {
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
    init_options = {
      usePlaceholders = true,
    },
  }
end)
