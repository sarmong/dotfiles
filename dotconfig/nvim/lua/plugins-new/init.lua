return {
  { "nvim-lua/plenary.nvim" }, -- required by many plugins
  { "nvim-tree/nvim-web-devicons" },

  { "folke/which-key.nvim" },

  -- Quality of life improvements --

  { "windwp/nvim-autopairs" },
  { "tpope/vim-surround" },
  { "bkad/CamelCaseMotion" },
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

  { "fedepujol/move.nvim" },
  -- { "andymass/vim-matchup", commit = commits.matchup }, -- perhaps not that essential
  { "lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead" } },
  { "sarmong/vim-smoothie" }, -- smooth scrolling

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("plugins.bqf")
    end,
  },
  { "mbbill/undotree" },
  { "azabiong/vim-highlighter" },
  {
    "mtth/scratch.vim",
    config = function()
      local cache_dir = os.getenv("XDG_CACHE_HOME")
      vim.g.scratch_persistence_file = cache_dir .. "/nvim/scratch_file"
    end,
  },
  -- { "lewis6991/impatient.nvim" },
  { "NvChad/nvim-colorizer.lua" },

  ------------------
  -- IDE features --
  ------------------
  { "mg979/vim-visual-multi" },
  { "windwp/nvim-spectre" }, -- search and replace
  {
    "numToStr/Comment.nvim",
  },
  { "metakirby5/codi.vim", cmd = { "Codi", "CodiUpdate" } },

  { "ThePrimeagen/refactoring.nvim" },

  { "scalameta/nvim-metals", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = function()
      require("lsp-file-operations").setup({ debug = false })
    end,
  },

  { "Pocco81/TrueZen.nvim" },

  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
    end,
  },
}
