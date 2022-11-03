local packer = req("packer")
packer.init({
  snapshot = "11-03",
  snapshot_path = vim.fn.resolve(
    vim.fn.stdpath("config") .. "/plugins/snapshots"
  ),
})

local commits = {
  packer = "6afb67460283f0e990d35d229fd38fdc04063e0a", -- https://github.com/wbthomason/packer.nvim
  barbar = "517b457630d84aff875287d8249791df95ff91ab", -- https://github.com/romgrk/barbar.nvim
  nvim_tree = "b07701f9da3ec62016ad46002a6c0ae9b414574c", -- https://github.com/kyazdani42/nvim-tree.lua
  which_key = "6885b669523ff4238de99a7c653d47b081b5506d", -- https://github.com/folke/which-key.nvim
  toggleterm = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda", -- https://github.com/akinsho/toggleterm.nvim
  wordmotion = "1f7eaf5d5733e39fb37f8e0de2f7f15e242dd39c", -- https://github.com/chaoren/vim-wordmotion
  visual_multi = "724bd53adfbaf32e129b001658b45d4c5c29ca1a", -- https://github.com/mg979/vim-visual-multi
  lualine = "edca2b03c724f22bdc310eee1587b1523f31ec7c", -- https://github.com/nvim-lualine/lualine.nvim
  lspconfig = "36765a3996f84efa3f33d998aedbd81f3bf0d1b4", -- https://github.com/neovim/nvim-lspconfig
  mason = "81f2e60e032ec78aac290b7c9edd721585f7d14a", -- https://github.com/williamboman/mason.nvim
  cmp = "714ccb7483d0ab90de1b93914f3afad1de8da24a", -- https://github.com/hrsh7th/nvim-cmp
  luasnip = "563827f00bb4fe43269e3be653deabc0005f1302", -- https://github.com/L3MON4D3/LuaSnip
  null_ls = "643c67a296711ff40f1a4d1bec232fa20b179b90", -- https://github.com/jose-elias-alvarez/null-ls.nvim
  treesitter = "c8533707679b99dc80d5f46f7b519081fb9c1ac9", -- https://github.com/nvim-treesitter/nvim-treesitter
  spectre = "6d877bc1f2262af1053da466e4acd909ad61bc18", -- https://github.com/nvim-pack/nvim-spectre
  vim_markdown = "c3f83ebb43b560af066d2a5d66bc77c6c05293b1", -- https://github.com/preservim/vim-markdown
}

packer.startup(function(use)
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim", commit = commits.packer })

  use({ "folke/which-key.nvim", commit = commits.which_key })
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
    commit = commits.lualine,
    requires = { "nvim-tree/nvim-web-devicons" },
  })

  -- Quality of life improvements --

  use({ "windwp/nvim-autopairs" })
  use({ "tpope/vim-surround" })
  use({ "chaoren/vim-wordmotion", commit = commits.wordmotion })
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

  ------------------
  -- IDE features --
  ------------------
  use({
    "romgrk/barbar.nvim",
    commit = commits.barbar,
    requires = { "nvim-tree/nvim-web-devicons" },
  })
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
    commit = commits.nvim_tree,
  })
  use({ "ojroques/nvim-bufdel" })
  use({
    "akinsho/toggleterm.nvim",
    commit = commits.toggleterm,
  })
  use({ "mg979/vim-visual-multi", commit = commits.visual_multi })
  use({
    "windwp/nvim-spectre",
    commit = commits.spectre,
    require = "nvim-lua/plenary.nvim",
  }) -- search and replace
  -- use({ "tpope/vim-commentary" })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
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
  use({ "tpope/vim-rhubarb" })
  use({ "f-person/git-blame.nvim" }) -- consider using zivyangll/git-blame.vim to show at the bottom
  use({ "mattn/vim-gist" })
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }) -- git lines on the left
  use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

  -- LSP --
  use({ "neovim/nvim-lspconfig", commit = commits.lspconfig })
  use({
    "williamboman/mason.nvim",
    commit = commits.mason,
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    commit = commits.null_ls,
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
    commit = commits.vim_markdown,
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
    commit = commits.treesitter,
  })
  use({ "p00f/nvim-ts-rainbow", commit = commits.ts_rainbow }) -- rainbow parantheses
  use({ "nvim-treesitter/nvim-treesitter-context" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "windwp/nvim-ts-autotag", commit = commits.ts_autotag })
  use({
    "nvim-treesitter/nvim-treesitter-refactor",
    commit = commits.ts_refactor,
  })
  use({ "nvim-treesitter/nvim-treesitter-textobjects" })
  use({ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" })

  -- Completion --
  use({ "hrsh7th/nvim-cmp", commit = commits.cmp }) -- @TODO Integrate with autopairs
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "ray-x/cmp-treesitter" })

  use({ "lukas-reineke/cmp-rg" })

  -- Snippets --
  use({ "L3MON4D3/LuaSnip", commit = commits.luasnip })
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
