-- Bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

local packer = require("packer")
packer.init()

local commits = {
  packer = "4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2",
  autopairs = "06535b1f1aefc98df464d180efa693bb696736c4",
  barbar = "be65945626fb6bf6058cae61d5176d156f923c11",
  nvim_tree = "618ea256137a28ea467bf82e4f2ab0b059dc3e0d",
  which_key = "a3c19ec5754debb7bf38a8404e36a9287b282430",
  toggleterm = "e62008fe5879eaecb105eb81e393f87d4607164c",
  wordmotion = "02e32fcb062553a8293992411677e12cacccb09d",
  visual_multi = "d5b820655e17c6ccd363885e5614652e4cffae95",
  lualine = "c8e5a69085e89c2bac6bd01c74fcb98f9ffa5cdc",
  indent_blankline = "cd5b800ed9545a944fc3b5bd55ef12da90944e7e",
  lspconfig = "f183d35725264d6184146eebcef1ba8338ddbc83",
  lsp_installer = "918ef1d4484d703e42424292399d19e36aab436f",
  cmp = "3192a0c57837c1ec5bf298e4f3ec984c7d2d60c0",
  luasnip = "69cb81cf7490666890545fef905d31a414edc15b",
  cmp_luasnip = "b10829736542e7cc9291e60bab134df1273165c9",
  null_ls = "80e1c2942f70bfdf16886a64692f274ef7356010",
  treesitter = "c9db4324351576d55e6a34d29a571843eff68ac3",
  ts_commentstring = "097df33c9ef5bbd3828105e4bee99965b758dc3f",
  ts_autotag = "0ceb4ef342bf1fdbb082ad4fa1fcfd0f864e1cba",
  ts_refactor = "a21ed4d294d2da5472ce5b70385d7871c4518a1e",
  ts_rainbow = "54ee09f540935c604c9a3d4aed83b7f5314f2caa",
  matchup = "97ffd1a2068049e812ddfd04b182f6a93c2c0394",
  spectre = "4a4cf2c981b077055ef7725959d13007e366ba23",
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

  use({ "windwp/nvim-autopairs", commit = commits.autopairs })
  use({ "tpope/vim-surround" })
  use({ "chaoren/vim-wordmotion", commit = commits.wordmotion })
  use({ "unblevable/quick-scope" })
  use({ "andymass/vim-matchup", commit = commits.matchup }) -- perhaps not that essential
  use({ "airblade/vim-rooter" }) -- automagically switches root directory
  use({ "lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead" } })
  use({
    "lukas-reineke/indent-blankline.nvim",
    commit = commits.indent_blankline,
  })
  use({ "psliwka/vim-smoothie" }) -- smooth scrolling
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("plugins.bqf")
    end,
  })
  use({ "mbbill/undotree" })

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
  use({ "tpope/vim-commentary" })
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })
  use({ "metakirby5/codi.vim", cmd = { "Codi", "CodiUpdate" } })

  -- Git
  use({ "tpope/vim-fugitive" })
  use({ "tpope/vim-rhubarb" })
  use({ "f-person/git-blame.nvim" }) -- consider using zivyangll/git-blame.vim to show at the bottom
  use({ "mattn/vim-gist" })
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }) -- git lines on the left

  -- LSP --
  use({ "neovim/nvim-lspconfig", commit = commits.lspconfig })
  use({ "williamboman/nvim-lsp-installer", commit = commits.lsp_installer })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    commit = commits.null_ls,
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({ "folke/lua-dev.nvim" }) -- completion for neovim lua api

  -- Other language features --
  use({
    "norcalli/nvim-colorizer.lua",
    ft = { "javascript", "typescript", "css", "scss" },
  })
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

  -- Completion --
  use({ "hrsh7th/nvim-cmp", commit = commits.cmp }) -- @TODO Integrate with autopairs
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "ray-x/cmp-treesitter" })
  -- @TODO check how it relates to lua-dev
  use({ "hrsh7th/cmp-nvim-lua" }) -- completion for neovim lua api
  -- Snippets --
  use({ "L3MON4D3/LuaSnip", commit = commits.luasnip })
  use({ "saadparwaiz1/cmp_luasnip", commit = commits.cmp_luasnip })

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
  -- use("christianchiarulli/nvcode-color-schemes.vim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
