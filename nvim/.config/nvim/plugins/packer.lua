local packer = req("packer")
packer.init()

local commits = {
  packer = "90b323bccc04ad9b23c971a85813a1405c7725a8", -- https://github.com/wbthomason/packer.nvim
  barbar = "8c6a2e6e472ff9b7dc0a53d9a3bd88f1fbc7da6d", -- https://github.com/romgrk/barbar.nvim
  nvim_tree = "81eb718394e489d2aebbffa730d2517d72ec7f9c", -- https://github.com/kyazdani42/nvim-tree.lua
  which_key = "bd4411a2ed4dd8bb69c125e339d837028a6eea71", -- https://github.com/folke/which-key.nvim
  toggleterm = "62683d927dfd30dc68441a5811fdcb6c9f176c42", -- https://github.com/akinsho/toggleterm.nvim
  wordmotion = "1f7eaf5d5733e39fb37f8e0de2f7f15e242dd39c", -- https://github.com/chaoren/vim-wordmotion
  visual_multi = "e23b98a8852255766e54bf7723a9d61fb5ab3143", -- https://github.com/mg979/vim-visual-multi
  lualine = "9076378ac1c53684c4fbfcf34b1277018c15c233", -- https://github.com/nvim-lualine/lualine.nvim
  lspconfig = "da7461b596d70fa47b50bf3a7acfaef94c47727d", -- https://github.com/neovim/nvim-lspconfig
  lsp_installer = "793f99660fa9212f52ee8b6164454e03ba1f42c9",
  cmp = "828768631bf224a1a63771aefd09c1a072b6fe84", -- https://github.com/hrsh7th/nvim-cmp
  luasnip = "faa525713e1244551877a4d89646a10f3c3fa31e", -- https://github.com/L3MON4D3/LuaSnip
  null_ls = "9d1f8dc1c8984e30efd8406aceba53dfadeaadbd", -- https://github.com/jose-elias-alvarez/null-ls.nvim
  treesitter = "67fb8939ff1f7e29659f5c4efe50a5689e3458bc", -- https://github.com/nvim-treesitter/nvim-treesitter
  spectre = "c553eb47ad9d82f8452119ceb6eb209c930640ec", -- https://github.com/nvim-pack/nvim-spectre
  vim_markdown = "3a9643961233c2812816078af8bd1eaabc530dce", -- https://github.com/preservim/vim-markdown
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
    },
  })
  use({
    "nvim-lualine/lualine.nvim",
    commit = commits.lualine,
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
    requires = { "kyazdani42/nvim-web-devicons" },
  })
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
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
    requires = { "kyazdani42/nvim-web-devicons" },
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
  use({ "williamboman/nvim-lsp-installer", commit = commits.lsp_installer })
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
