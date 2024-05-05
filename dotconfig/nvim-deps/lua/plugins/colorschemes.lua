Plugin("sainnhe/gruvbox-material")

req("mini.deps").later(function()
  Plugin("sainnhe/everforest")
  Plugin({ "catppuccin/nvim", name = "catppuccin" })

  req("catppuccin").setup({
    integrations = {
      cmp = true,
      aerial = true,
      alpha = true,
      barbar = true,
      fidget = true,
      harpoon = true,
      mason = true,
      window_picker = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      which_key = true,
    },
  })
  Plugin("ellisonleao/gruvbox.nvim")
  Plugin("AlphaTechnolog/onedarker.nvim")
  Plugin("navarasu/onedark.nvim")
  Plugin("folke/tokyonight.nvim")
  -- "christianchiarulli/nvcode-color-schemes.vim",
end)
