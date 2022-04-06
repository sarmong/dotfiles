-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- require('packer').init({display = {non_interactive = true}})
require("packer").init({ display = { auto_clean = false } })

local commits = {
  packer = "851c62c5ecd3b5adc91665feda8f977e104162a5",
  autopairs = "04cd1779f81e9d50d5a116c5dccd054b275bd191",
  barbar = "6e638309efcad2f308eb9c5eaccf6f62b794bbab",
  nvim_tree = "6eebc10ed8f97aae29a2ef9561ce2d922c668639",
  which_key = "312c386ee0eafc925c27869d2be9c11ebdb807eb",
  toggleterm = "265bbff68fbb8b2a5fb011272ec469850254ec9f",
  wordmotion = "02e32fcb062553a8293992411677e12cacccb09d",
  visual_multi = "e20908963d9b0114e5da1eacbc516e4b09cf5803",
  lualine = "3a17c8f05aae1f148b8af595b46fea18b74d0573",
  indent_blankline = "0f8df7e43f0cae4c44e0e8383436ad602f333419",
  lspconfig = "1aa05163361331e881c6130781c01d93b63f9232",
  lsp_installer = "2e81b1d86f90c8a05d7f875599818612bd68e1a7",
  cmp = "b11f8bbee3d7ba5190b043e23bd6f5b9cb82382c",
  luasnip = "6bcd3bb65ebb3e82afb460587590a80350eba1a1",
  cmp_luasnip = "7bd2612533db6863381193df83f9934b373b21e1",
  null_ls = "80e1c2942f70bfdf16886a64692f274ef7356010",
  treesitter = "c9db4324351576d55e6a34d29a571843eff68ac3",
  ts_commentstring = "097df33c9ef5bbd3828105e4bee99965b758dc3f",
  ts_autotag = "0ceb4ef342bf1fdbb082ad4fa1fcfd0f864e1cba",
  ts_refactor = "a21ed4d294d2da5472ce5b70385d7871c4518a1e",
  ts_rainbow = "54ee09f540935c604c9a3d4aed83b7f5314f2caa",
  fzf = "176ee6910ffe40d9007ff9bc1b2720e3d729c48a",
  fzf_vim = "d6aa21476b2854694e6aa7b0941b8992a906c5ec",
  fzf_checkout = "4d5ecae74460de8fed4f743f6bd53c4c31d32797",
  matchup = "97ffd1a2068049e812ddfd04b182f6a93c2c0394",
  spectre = "4a4cf2c981b077055ef7725959d13007e366ba23",
}

-- @TODO - use config option of 'use'
return require("packer").startup(function(use)
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim", commit = commits.packer })

  use({ "windwp/nvim-autopairs", commit = commits.autopairs })
  use({
    "romgrk/barbar.nvim",
    commit = commits.barbar,
    requires = { "kyazdani42/nvim-web-devicons" },
  })
  -- @TODO update to main once #878 is merged
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    commit = commits.nvim_tree,
  })
  use({ "tpope/vim-commentary" })

  use({ "folke/which-key.nvim", commit = commits.which_key })

  use({
    "akinsho/toggleterm.nvim",
    commit = commits.toggleterm,
  })

  use({ "chaoren/vim-wordmotion", commit = commits.wordmotion })

  use({ "mg979/vim-visual-multi", commit = commits.visual_multi })

  use({
    "nvim-lualine/lualine.nvim",
    commit = commits.lualine,
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  use("airblade/vim-rooter") -- automagically switches root directory

  use("metakirby5/codi.vim")

  use("unblevable/quick-scope")

  use({ "andymass/vim-matchup", commit = commits.matchup }) -- looks nice, but perhaps not that essential

  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    commit = commits.indent_blankline,
  })

  use({
    "windwp/nvim-spectre",
    commit = commits.spectre,
    require = "nvim-lua/plenary.nvim",
  })

  -- use { 'norcalli/nvim-colorizer.lua' }

  -- LSP

  use({ "neovim/nvim-lspconfig", commit = commits.lspconfig })
  use({ "williamboman/nvim-lsp-installer", commit = commits.lsp_installer })
  use({ "hrsh7th/nvim-cmp", commit = commits.cmp }) -- @TODO Integrate with autopairs
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("ray-x/cmp-treesitter")
  use("hrsh7th/cmp-nvim-lua")

  use("iloginow/vim-stylus")

  -- Snippets
  use({ "L3MON4D3/LuaSnip", commit = commits.luasnip })
  use({ "saadparwaiz1/cmp_luasnip", commit = commits.cmp_luasnip })

  use("rafamadriz/friendly-snippets")
  use("ChristianChiarulli/html-snippets")
  use({
    "dsznajder/vscode-es7-javascript-react-snippets",
    run = "yarn install --frozen-lockfile && yarn compile",
    commit = "2a6a1ffac598d7f5b4097d06c4190c5bcced99d9",
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    commit = commits.null_ls,
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    commit = commits.treesitter,
  })
  use({ "p00f/nvim-ts-rainbow", commit = commits.ts_rainbow }) -- rainbow parantheses
  use({
    "JoosepAlviste/nvim-ts-context-commentstring",
    commit = commits.ts_commentstring,
  })
  use({ "windwp/nvim-ts-autotag", commit = commits.ts_autotag })
  use({
    "nvim-treesitter/nvim-treesitter-refactor",
    commit = commits.ts_refactor,
  })
  use({ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" })

  -- use({ "junegunn/fzf", commit = commits.fzf })
  -- use({ "junegunn/fzf.vim", commit = commits.fzf_vim })
  -- use({ "stsewd/fzf-checkout.vim", commit = commits.fzf_checkout })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
  })

  -- Git
  use("tpope/vim-fugitive")
  use("tpope/vim-rhubarb")
  use("f-person/git-blame.nvim") -- consider using zivyangll/git-blame.vim to show at the bottom
  use("mattn/vim-gist")
  use({
    "lewis6991/gitsigns.nvim", -- git lines on the left
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  use({ "kevinhwang91/nvim-bqf" })

  use({ "plasticboy/vim-markdown" })
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install" })

  -- completion for neovim lua api
  use("folke/lua-dev.nvim")

  use({
    "nvim-neorg/neorg",
    requires = "nvim-lua/plenary.nvim",
  })

  use({ "lambdalisue/suda.vim" })

  -------------

  -- Color
  -- use("christianchiarulli/nvcode-color-schemes.vim")
  use({ "AlphaTechnolog/onedarker.nvim" })
  use("navarasu/onedark.nvim")
  use("folke/tokyonight.nvim")

  -- General Plugins
  use("mbbill/undotree")

  -- Try out
  -- use 'vim-test/vim-test'
  -- use 'godlygeek/tabular'
  -- use {'raghur/vim-ghost', run = ':GhostInstall'} -- nice for codepen etc.
  -- use 'ryanoasis/vim-devicons' -- maybe use them instead
  -- use 'MattesGroeger/vim-bookmarks'
  -- use 'b3nj5m1n/kommentary'
  -- use {
  --     'glacambre/firenvim',
  --     run = function()
  --         vim.fn['firenvim#install'](1)
  --     end
  -- }
  if packer_bootstrap then
    require("packer").sync()
  end
end)
