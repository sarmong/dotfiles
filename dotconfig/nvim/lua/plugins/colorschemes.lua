return {
  { "sainnhe/everforest" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme("tokyonight-day")
      -- require("catppuccin").setup({
      --   integrations = {
      --     cmp = true,
      --     aerial = true,
      --     alpha = true,
      --     barbar = true,
      --     fidget = true,
      --     harpoon = true,
      --     mason = true,
      --     window_picker = true,
      --     gitsigns = true,
      --     nvimtree = true,
      --     treesitter = true,
      --     which_key = true,
      --   },
      -- })
    end,
  },
  { "ellisonleao/gruvbox.nvim" },
  { "sainnhe/gruvbox-material" },
  { "AlphaTechnolog/onedarker.nvim" },
  { "navarasu/onedark.nvim" },
  { "folke/tokyonight.nvim" },
  -- "christianchiarulli/nvcode-color-schemes.vim",
}
