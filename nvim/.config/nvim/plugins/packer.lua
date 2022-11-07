local packer = req("packer")
packer.init({
  snapshot = "11-07",
  snapshot_path = vim.fn.resolve(
    vim.fn.stdpath("config") .. "/plugins/snapshots"
  ),
})

packer.startup(function(use)
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim" })

  use({ "folke/which-key.nvim" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
  })

  -- Quality of life improvements --

  use({ "windwp/nvim-autopairs" })
  use({ "tpope/vim-surround" })
  use({ "chaoren/vim-wordmotion" })
  use("fedepujol/move.nvim")
  use({ "unblevable/quick-scope" })
  -- use({ "andymass/vim-matchup", commit = commits.matchup }) -- perhaps not that essential
  use({
    "ahmedkhalf/project.nvim",
  }) -- automagically switches root directory
  use({ "lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead" } })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "psliwka/vim-smoothie" }) -- smooth scrolling
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("plugins.bqf")
    end,
  })
  use({ "mbbill/undotree" })
  use({
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = {
          insert_only = false,
        },
      })
    end,
  })
  use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" })
  use("azabiong/vim-highlighter")
  use({
    "mtth/scratch.vim",
    config = function()
      local cache_dir = os.getenv("XDG_CACHE_HOME")
      vim.g.scratch_persistence_file = cache_dir .. "/nvim/scratch_file"
    end,
  })
  use("lewis6991/impatient.nvim")
  use("phaazon/hop.nvim")
  use("chentoast/marks.nvim")

  ------------------
  -- IDE features --
  ------------------
  use({
    "romgrk/barbar.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
  })
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
  })
  use({ "ojroques/nvim-bufdel" })
  use({
    "akinsho/toggleterm.nvim",
  })
  use({ "mg979/vim-visual-multi" })
  use({
    "windwp/nvim-spectre",
    require = "nvim-lua/plenary.nvim",
  }) -- search and replace
  -- use({ "tpope/vim-commentary" })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  })
  use({
    "goolord/alpha-nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
  })
  use({ "metakirby5/codi.vim", cmd = { "Codi", "CodiUpdate" } })

  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })
  use({
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({})
    end,
  })

  -- Git
  use({ "tpope/vim-fugitive" })
  use({ "f-person/git-blame.nvim" }) -- consider using zivyangll/git-blame.vim to show at the bottom
  use({ "mattn/vim-gist" })
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }) -- git lines on the left
  use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use({ "ruifm/gitlinker.nvim" })

  -- LSP --
  use({ "neovim/nvim-lspconfig" })
  use({
    "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({ "folke/lua-dev.nvim" }) -- @TODO this is currently not used

  -- Other language features --
  use({ "norcalli/nvim-colorizer.lua" })
  use({
    "plasticboy/vim-markdown",
    ft = "markdown",
    config = function()
      require("plugins.vim-markdown")
    end,
  })
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  })

  -- Treesitter --
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use({ "p00f/nvim-ts-rainbow" }) -- rainbow parantheses
  use({ "nvim-treesitter/nvim-treesitter-context" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "windwp/nvim-ts-autotag" })
  use({
    "nvim-treesitter/nvim-treesitter-refactor",
  })
  use({ "nvim-treesitter/nvim-treesitter-textobjects" })
  use({ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" })

  -- Completion --
  use({ "hrsh7th/nvim-cmp" }) -- @TODO Integrate with autopairs
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "ray-x/cmp-treesitter" })

  use({ "lukas-reineke/cmp-rg" })

  -- Snippets --
  use({ "L3MON4D3/LuaSnip" })
  use({ "saadparwaiz1/cmp_luasnip" })

  use({ "rafamadriz/friendly-snippets" })
  use({ "ChristianChiarulli/html-snippets" })
  use({
    "dsznajder/vscode-es7-javascript-react-snippets",
    run = "yarn install --frozen-lockfile && yarn compile",
    commit = "2a6a1ffac598d7f5b4097d06c4190c5bcced99d9",
  })

  -- Color
  use({ "AlphaTechnolog/onedarker.nvim" })
  use({ "navarasu/onedark.nvim" })
  use({ "folke/tokyonight.nvim" })
  use({ "ellisonleao/gruvbox.nvim" })
  -- use("christianchiarulli/nvcode-color-schemes.vim")

  use("Pocco81/TrueZen.nvim")
  use({
    "nvim-orgmode/orgmode",
    requires = {
      -- "lukas-reineke/headlines.nvim",
      "akinsho/org-bullets.nvim",
    },
  })
  use("martinlroth/vim-devicetree")

  if _G.packer_bootstrap then
    require("packer").sync()
  end
end)
