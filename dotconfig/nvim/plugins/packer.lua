local packer = req("packer")
packer.init({
  snapshot_path = vim.fn.resolve(
    vim.fn.stdpath("config") .. "/plugins/snapshots"
  ),
})

packer.startup(function(use)
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim" })
  use({ "nvim-lua/plenary.nvim" }) -- required by many plugins
  use({ "nvim-tree/nvim-web-devicons" })

  use({ "folke/which-key.nvim" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
  })
  use({ "nvim-lualine/lualine.nvim" })

  -- Quality of life improvements --

  use({ "windwp/nvim-autopairs" })
  use({ "tpope/vim-surround" })
  use({ "bkad/CamelCaseMotion" })
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

  use({ "fedepujol/move.nvim" })
  -- use({ "andymass/vim-matchup", commit = commits.matchup }) -- perhaps not that essential
  use({ "ahmedkhalf/project.nvim" }) -- automagically switches root directory
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
  use({ "ThePrimeagen/harpoon" })
  use({ "azabiong/vim-highlighter" })
  use({
    "mtth/scratch.vim",
    config = function()
      local cache_dir = os.getenv("XDG_CACHE_HOME")
      vim.g.scratch_persistence_file = cache_dir .. "/nvim/scratch_file"
    end,
  })
  use({ "lewis6991/impatient.nvim" })
  use({ "chentoast/marks.nvim" })
  use({ "NvChad/nvim-colorizer.lua" })
  use({ "s1n7ax/nvim-window-picker" })

  ------------------
  -- IDE features --
  ------------------
  use({ "romgrk/barbar.nvim" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "ojroques/nvim-bufdel" })
  use({ "mg979/vim-visual-multi" })
  use({ "windwp/nvim-spectre" }) -- search and replace
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
  use({ "goolord/alpha-nvim" })
  use({ "metakirby5/codi.vim", cmd = { "Codi", "CodiUpdate" } })

  use({ "ThePrimeagen/refactoring.nvim" })
  use({
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({})
    end,
  })

  -- Git
  use({ "tpope/vim-fugitive" })
  use({ "f-person/git-blame.nvim" }) -- consider using zivyangll/git-blame.vim to show at the bottom
  use({ "lewis6991/gitsigns.nvim" }) -- git lines on the left
  use({ "NeogitOrg/neogit" })
  use({ "sindrets/diffview.nvim" })
  use({ "ruifm/gitlinker.nvim" })
  use({ "pwntester/octo.nvim" })

  -- LSP --
  use({ "neovim/nvim-lspconfig" })
  use({
    "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
  })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  -- @TODO remove tag when it's updated
  use({ "j-hui/fidget.nvim", tag = "legacy" })

  -- Other language features --
  use({ "jose-elias-alvarez/typescript.nvim" })
  use({ "folke/lua-dev.nvim" }) -- @TODO this is currently not used
  use({
    "git@github.com:sarmong/markdown.nvim.git",
    config = function()
      require("markdown").setup({})
    end,
  })
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  })

  use({
    "sarmong/headlines.nvim",
    config = function()
      require("headlines").setup()
    end,
  })

  -- Treesitter --
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "p00f/nvim-ts-rainbow" }) -- rainbow parantheses
  use({ "nvim-treesitter/nvim-treesitter-context" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "windwp/nvim-ts-autotag" })
  use({ "nvim-treesitter/nvim-treesitter-refactor" })
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
  })

  -- Color
  use({ "AlphaTechnolog/onedarker.nvim" })
  use({ "navarasu/onedark.nvim" })
  use({ "folke/tokyonight.nvim" })
  use({ "ellisonleao/gruvbox.nvim" })
  use({ "sainnhe/gruvbox-material" })
  -- use("christianchiarulli/nvcode-color-schemes.vim")

  use({ "Pocco81/TrueZen.nvim" })
  use({ "martinlroth/vim-devicetree" })
  use({ "sarmong/lf-vim" })
  use({ "sarmong/newsboat.vim" })
  use({ "kovetskiy/sxhkd-vim" })
  use({ "sarmong/conky-syntax.vim" })
  use({ "elkowar/yuck.vim" })
  use({ "fladson/vim-kitty" })
  use({
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
    end,
  })

  if _G.packer_bootstrap then
    require("packer").sync()
  end
end)
