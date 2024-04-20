return {
  { "nvim-lua/plenary.nvim" }, -- required by many plugins
  { "nvim-tree/nvim-web-devicons" },

  -- Quality of life improvements --

  { "lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead" } },

  { "mbbill/undotree" },
  {
    "mtth/scratch.vim",
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
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = function()
      require("lsp-file-operations").setup({ debug = false })
    end,
  },

  { "Pocco81/TrueZen.nvim" },
}
