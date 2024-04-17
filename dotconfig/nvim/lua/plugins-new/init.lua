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
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  },
  { "metakirby5/codi.vim", cmd = { "Codi", "CodiUpdate" } },

  { "ThePrimeagen/refactoring.nvim" },

  -- Git
  { "tpope/vim-fugitive" },
  { "f-person/git-blame.nvim" }, -- consider using zivyangll/git-blame.vim to show at the bottom
  { "lewis6991/gitsigns.nvim" }, -- git lines on the left
  { "NeogitOrg/neogit" },
  { "sindrets/diffview.nvim" },
  { "ruifm/gitlinker.nvim" },
  { "pwntester/octo.nvim" },

  -- LSP --
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "gbprod/none-ls-shellcheck.nvim" },
  },
  { "stevearc/conform.nvim" },
  -- @TODO remove tag when it's updated
  { "j-hui/fidget.nvim" },
  { "scalameta/nvim-metals", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = function()
      require("lsp-file-operations").setup({ debug = false })
    end,
  },

  -- Other language features --
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "folke/lua-dev.nvim" }, -- @TODO this is currently not used
  -- {
  --   "git@github.com:sarmong/markdown.nvim.git",
  --   config = function()
  --     require("markdown").setup({})
  --   end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
    ft = "markdown",
  },

  {
    "sarmong/headlines.nvim",
    config = function()
      -- @TODO fix (See PR)
      -- require("headlines").setup()
    end,
  },

  -- Treesitter --
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "p00f/nvim-ts-rainbow" }, -- rainbow parantheses
  { "nvim-treesitter/nvim-treesitter-context" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "windwp/nvim-ts-autotag" },
  { "nvim-treesitter/nvim-treesitter-refactor" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  -- Completion --
  { "hrsh7th/nvim-cmp" }, -- @TODO Integrate with autopairs
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "ray-x/cmp-treesitter" },

  { "lukas-reineke/cmp-rg" },

  -- Snippets --
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  { "rafamadriz/friendly-snippets" },
  { "ChristianChiarulli/html-snippets" },
  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    build = "yarn install --frozen-lockfile && yarn compile",
  },

  -- Color
  { "AlphaTechnolog/onedarker.nvim" },
  { "navarasu/onedark.nvim" },
  { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "sainnhe/gruvbox-material" },
  -- "christianchiarulli/nvcode-color-schemes.vim",

  { "Pocco81/TrueZen.nvim" },
  { "martinlroth/vim-devicetree" },
  { "sarmong/lf-vim" },
  { "sarmong/newsboat.vim" },
  { "kovetskiy/sxhkd-vim" },
  { "sarmong/conky-syntax.vim" },
  { "elkowar/yuck.vim" },
  { "fladson/vim-kitty" },
  -- { "xuhdev/vim-latex-live-preview" },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
    end,
  },
}
