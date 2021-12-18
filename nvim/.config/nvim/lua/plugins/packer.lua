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

local commits = {
    packer = "851c62c5ecd3b5adc91665feda8f977e104162a5",
    autopairs = "04cd1779f81e9d50d5a116c5dccd054b275bd191",
    barbar = "6e638309efcad2f308eb9c5eaccf6f62b794bbab",
    nvim_tree = "0aec64d56c9448a039408228d410a01c41125d48",
    which_key = "312c386ee0eafc925c27869d2be9c11ebdb807eb",
    toggleterm = "265bbff68fbb8b2a5fb011272ec469850254ec9f",
    wordmotion = "02e32fcb062553a8293992411677e12cacccb09d",
    visual_multi = "e20908963d9b0114e5da1eacbc516e4b09cf5803",
    lualine = "3a17c8f05aae1f148b8af595b46fea18b74d0573",
    indent_blankline = "0f8df7e43f0cae4c44e0e8383436ad602f333419"
}

-- @TODO - use config option of 'use'
return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', commit = commits.packer}

    use {'windwp/nvim-autopairs', commit = commits.autopairs}
    use {
      'romgrk/barbar.nvim',
      commit = commits.barbar,
      requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        commit = commits.nvim_tree,
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use { 'tpope/vim-commentary' }

    use { 'folke/which-key.nvim', commit = commits.which_key }

    use { "akinsho/toggleterm.nvim", commit = commits.toggleterm }

    use { 'chaoren/vim-wordmotion', commit = commits.wordmotion }

    use { 'mg979/vim-visual-multi', commit =  commits.visual_multi }

    use {
      'nvim-lualine/lualine.nvim',
      commit = commits.lualine,
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

    use { 'lukas-reineke/indent-blankline.nvim', commit = commits.indent_blankline }

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
