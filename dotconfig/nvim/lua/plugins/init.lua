req("plugins.alpha")
req("plugins.colorschemes")

req("mini.deps").later(function()
  Plugin({
    source = "sarmong/neoconf.nvim",
    depends = { "neovim/nvim-lspconfig" },
  })
  req("neoconf").setup()

  Plugin("rcarriga/nvim-notify")
  vim.notify = req("notify")

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
