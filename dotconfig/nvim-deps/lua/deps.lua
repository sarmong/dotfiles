local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.deps",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.deps | helptags ALL")
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

vim.g.mapleader = " "
require("mini.deps").setup({
  job = {
    -- n_threads = 100,
  },
  path = {
    package = path_package,
    snapshot = vim.fn.stdpath("config") .. "/deps-snap.lua",
  },
})

local deps = req("mini.deps")

-- @TODO move to shortcuts
function Plugin(spec)
  if spec[1] then
    spec.source = spec[1]
  end
  req("mini.deps").add(spec)
end

deps.now(function()
  req("plugins.which-key")
  req("plugins.ui")
  req("plugins.colorschemes")

  deps.later(function()
    req("plugins")
    req("plugins.navigation.buffers")
    req("plugins.scroll")

    req("plugins.coding")
    req("plugins.bqf")
    req("plugins.navigation")
    req("plugins.navigation.nvim-tree")
    req("plugins.languages.cmp")
    req("plugins.languages.formatting")
    req("plugins.languages.null-ls")

    req("plugins.languages.lsp")
    req("plugins.languages.debug")
    req("plugins.navigation.telescope")
    req("plugins.languages.markdown")

    req("plugins.languages.misc")
    req("plugins.languages.treesitter")
    req("plugins.git")
    req("plugins.git.gitsigns")
    req("plugins.git.octo")
  end)
end)
