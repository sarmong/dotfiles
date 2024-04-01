local default_conf = req("lsp.servers.default")

local metals_config = req("metals").bare_config()
metals_config.on_attach = function(client, bufnr)
  default_conf.on_attach(client, bufnr)
end

local nvim_metals_group =
  vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    req("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
