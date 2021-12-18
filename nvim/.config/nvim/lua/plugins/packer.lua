local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- require('packer').init({display = {non_interactive = true}})
require('packer').init({display = {auto_clean = false}})

-- @TODO - use config option of 'use'
return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    use 'windwp/nvim-autopairs'
    use {
      'romgrk/barbar.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use { 'tpope/vim-commentary' }

    use { 'folke/which-key.nvim' }

    use { "akinsho/toggleterm.nvim" }

    use 'chaoren/vim-wordmotion'

    use 'mg979/vim-visual-multi'

    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use 'airblade/vim-rooter' -- automagically switches root directory

    use 'metakirby5/codi.vim'

    use 'unblevable/quick-scope'

    use 'andymass/vim-matchup' -- looks nice, but perhaps not that essential

    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    use { 'lukas-reineke/indent-blankline.nvim' }

    use 'f-person/git-blame.nvim' -- consider using zivyangll/git-blame.vim to show at the bottom

    -- use { 'norcalli/nvim-colorizer.lua' }

    -------------


    use 'neoclide/coc.nvim'
    use {'rescript-lang/vim-rescript'}

    use {'dsznajder/vscode-es7-javascript-react-snippets', run = 'yarn install --frozen-lockfile && yarn compile'}

    -- Might be needed for LSP
    -- use {'rafamadriz/friendly-snippets', run = 'yarn install --frozen-lockfile'}
    -- use 'hrsh7th/nvim-cmp' - might be needed without coc. Integrate with autopairs 
    -- use 'sbdchd/neoformat' -- format isntead of prettier (support other languages too)
    -- use {
    --   'lewis6991/gitsigns.nvim', -- git lines on the left
    --   requires = {
    --    'nvim-lua/plenary.nvim'
    --   },
    --   -- tag = 'release' -- To use the latest release
    -- }
    
    -- Try out
    -- use 'vimwiki/vimwiki'
    -- use 'vim-test/vim-test'
    -- use 'godlygeek/tabular'
    -- use 'junegunn/goyo.vim'
    -- use {'raghur/vim-ghost', run = ':GhostInstall'} -- nice for codepen etc.
    -- use 'ryanoasis/vim-devicons' -- maybe use them instead
    -- use 'kevinhwang91/nvim-bqf' -- after learning quickfix
    -- use 'MattesGroeger/vim-bookmarks'

    use 'plasticboy/vim-markdown'

       -- Autocomplete
    use 'hrsh7th/vim-vsnip'
    use "rafamadriz/friendly-snippets"
    use 'ChristianChiarulli/html-snippets'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-treesitter/playground'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'windwp/nvim-ts-autotag'

    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'stsewd/fzf-checkout.vim'

    -- Telescope
    -- use 'nvim-lua/popup.nvim'
    -- use 'nvim-lua/plenary.nvim'
    -- use 'nvim-telescope/telescope.nvim'
    -- use 'nvim-telescope/telescope-media-files.nvim'
    -- use 'nvim-telescope/telescope-project.nvim'

    -- Color
    use 'christianchiarulli/nvcode-color-schemes.vim'

    -- Git
	use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    -- Easily Create Gists
    use 'mattn/vim-gist'

    -- General Plugins
    -- use 'ChristianChiarulli/dashboard-nvim'
    use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install'}
    use 'mbbill/undotree'

    -- use 'b3nj5m1n/kommentary'
    -- use {
    --     'glacambre/firenvim',
    --     run = function()
    --         vim.fn['firenvim#install'](1)
    --     end
    -- }
end)
