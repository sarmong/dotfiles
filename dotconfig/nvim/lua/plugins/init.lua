return {
  { "nvim-lua/plenary.nvim" }, -- required by many plugins
  { "nvim-tree/nvim-web-devicons" },
  {
    "sarmong/neoconf.nvim",
    event = "VeryLazy",
    config = function()
      req("neoconf").setup()
    end,
  },
  -- Quality of life improvements --

  {
    "lambdalisue/suda.vim",
    event = "VeryLazy",
    cmd = { "SudaWrite", "SudaRead" },
  },

  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      map("n", "<leader>u", cmd.bind("UndotreeToggle"), "[u]ndo tree")
    end,
  },
  {
    "mtth/scratch.vim",
    event = "VeryLazy",
    config = function()
      local cache_dir = os.getenv("XDG_CACHE_HOME")
      vim.g.scratch_persistence_file = cache_dir .. "/nvim/scratch_file"
    end,
  },

  ------------------
  -- IDE features --
  ------------------

  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = function()
      require("lsp-file-operations").setup({ debug = false })
    end,
  },

  { "Pocco81/TrueZen.nvim", event = "VeryLazy" },
}
