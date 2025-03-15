Plugin("williamboman/mason.nvim")
Plugin("WhoIsSethDaniel/mason-tool-installer.nvim")

req("mason-registry").refresh()
req("mason").setup()
req("modules.mason-lock").setup_hooks()

local tools = req("plugins.ide.contrib").state.mason
local lock = req("modules.mason-lock").get_lockfile()

local tools_with_versions = {}
for _, tool in ipairs(tools) do
  if lock[tool] then
    table.insert(tools_with_versions, { tool, version = lock[tool] })
  else
    table.insert(tools_with_versions, tool)
  end
end

req("mason-tool-installer").setup({
  ensure_installed = tools_with_versions,
  run_on_start = false,
})
req("mason-tool-installer").check_install()
