local plugins_root = "plugins.ide.langs"

local plugins_path = vim.fn.stdpath("config")
  .. "/lua/"
  .. plugins_root:gsub("%.", "/")

vim.iter(vim.fs.dir(plugins_path)):each(function(v)
  local package_name = plugins_root .. "." .. v:match("^(.+)%.lua$")
  req(package_name)
end)

req("plugins.ide.protocols.mason")
req("plugins.ide.protocols.cmp")
req("plugins.ide.protocols.treesitter")
req("plugins.ide.protocols.lsp")
req("plugins.ide.protocols.conform")
req("plugins.ide.protocols.null-ls")
req("plugins.ide.protocols.dap")

local setups = req("plugins.ide.contrib").state.setup
for _, setup_fn in ipairs(setups) do
  setup_fn()
end
