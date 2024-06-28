local contrib = req("plugins.ide.contrib")

Plugin("scalameta/nvim-metals")

contrib.mason({ "pylsp", "pyright", "black" })

contrib.formatters("python", "black")
contrib.ts_parsers("scala")

contrib.setup(function()
  local metals_config = req("metals").bare_config()

  local nvim_metals_group =
    vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
      req("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })
end)
