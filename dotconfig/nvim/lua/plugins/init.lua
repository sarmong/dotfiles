req("plugins.alpha")
req("plugins.colorschemes")

req("mini.deps").later(function()
  req("plugins.notify")
  Plugin("nvim-lua/plenary.nvim")
  Plugin("nvim-tree/nvim-web-devicons")

  req("plugins.which-key")
  req("plugins.ui")
  req("plugins.misc")
  req("plugins.navigation.buffers")
  req("plugins.scroll")
  req("plugins.misc")

  req("plugins.coding")
  req("plugins.bqf")
  req("plugins.navigation")
  req("plugins.navigation.nvim-tree")
  -- req("plugins.languages.cmp")
  req("plugins.ide")
  -- req("plugins.languages.formatting")
  -- req("plugins.languages.null-ls")

  -- req("plugins.languages.lsp")
  -- req("plugins.languages.debug")
  req("plugins.navigation.telescope")
  -- req("plugins.languages.markdown")

  -- req("plugins.languages.misc")
  -- req("plugins.languages.treesitter")
  if not _G.lean_mode then
    req("plugins.git")
    req("plugins.git.gitsigns")
    req("plugins.git.octo")
  end
end)
