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


    use 'neoclide/coc.nvim'
    use {'rescript-lang/vim-rescript'}

    use {'dsznajder/vscode-es7-javascript-react-snippets', run = 'yarn install --frozen-lockfile && yarn compile'}

    -- Might be needed for LSP
    -- use {'rafamadriz/friendly-snippets', run = 'yarn install --frozen-lockfile'}
    -- use 'hrsh7th/nvim-cmp' - might be needed without coc. Integrate with autopairs 

    use 'sbdchd/neoformat'
    
    -- use 'vimwiki/vimwiki'
    use 'vim-test/vim-test'
    --
    use 'chaoren/vim-wordmotion'
    use 'mg979/vim-visual-multi'
    use 'godlygeek/tabular'
    use 'plasticboy/vim-markdown'
    use {'raghur/vim-ghost', run = ':GhostInstall'}

       -- Autocomplete
    use 'mattn/emmet-vim'
    use 'hrsh7th/vim-vsnip'
    use "rafamadriz/friendly-snippets"
    use 'ChristianChiarulli/html-snippets'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'p00f/nvim-ts-rainbow'
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
    use 'nvim-treesitter/playground'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'windwp/nvim-ts-autotag'

    -- Icons
    use 'ryanoasis/vim-devicons'

    -- Status Line and Bufferline
    use 'glepnir/galaxyline.nvim'
    
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'stsewd/fzf-checkout.vim'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope-project.nvim'

   -- use 'preservim/nerdtree' 

    -- Color
    use 'christianchiarulli/nvcode-color-schemes.vim'
    use { 'norcalli/nvim-colorizer.lua', config = function() require'nv-colorizer' end}
    use 'sheerun/vim-polyglot'

    -- Git
    use 'f-person/git-blame.nvim'
	use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    -- Easily Create Gists
    use 'mattn/vim-gist'
    use 'mattn/webapi-vim'

    -- Navigation
    use 'unblevable/quick-scope' -- hop may replace you
    use 'phaazon/hop.nvim'

    -- General Plugins
    use 'liuchengxu/vim-which-key'
    use 'kevinhwang91/nvim-bqf'
    use 'airblade/vim-rooter'
    use 'ChristianChiarulli/dashboard-nvim'
    use 'metakirby5/codi.vim'
    use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install'}
    use 'voldikss/vim-floaterm'
    use 'junegunn/goyo.vim'
    use 'andymass/vim-matchup'
    use 'MattesGroeger/vim-bookmarks'
    use 'mbbill/undotree'

    -- TODO put this back when stable for indent lines
    -- vim.g.indent_blankline_space_char = ''
    -- use 'b3nj5m1n/kommentary'
    -- use {
    --     'glacambre/firenvim',
    --     run = function()
    --         vim.fn['firenvim#install'](1)
    --     end
    -- }
end)
