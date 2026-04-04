req("plugins.alpha")
req("plugins.colorschemes")
req("plugins.ide.protocols.treesitter")

req("mini.deps").later(function()
  req("plugins.notify")
  Plugin("nvim-lua/plenary.nvim")
  Plugin("nvim-tree/nvim-web-devicons")

  req("plugins.which-key")
  req("plugins.ui")
  req("plugins.misc")
  req("plugins.navigation.buffers")
  req("plugins.scroll")
  req("plugins.multicursor")

  req("plugins.coding")
  req("plugins.bqf")
  req("plugins.navigation")
  req("plugins.navigation.nvim-tree")

  req("plugins.ide")

  req("plugins.navigation.telescope")

  if not _G.lean_mode then
    req("plugins.git")
    req("plugins.git.gitsigns")
    req("plugins.git.octo")
  end
end)
