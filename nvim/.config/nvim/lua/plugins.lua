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

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    use 'neoclide/coc.nvim'
    use {'iamcco/coc-vimlsp', run = 'yarn install --frozen-lockfile'}
    use {'neoclide/coc-tsserver', run = 'yarn install --frozen-lockfile'}
    use {'bmatcuk/coc-stylelintplus', run = 'yarn install --frozen-lockfile'}
    use {'neoclide/coc-snippets', run = 'yarn install --frozen-lockfile'}

    use {'josa42/coc-lua', run = 'yarn install --frozen-lockfile'}
    use {'neoclide/coc-git', run = 'yarn install --frozen-lockfile'}
    use {'neoclide/coc-prettier', run = 'yarn install --frozen-lockfile'}
    use {'neoclide/coc-eslint', run = 'yarn install --frozen-lockfile'}
    use {'iamcco/coc-vimlsp', run = 'yarn install --frozen-lockfile'}
    use {'josa42/coc-sh', run = 'yarn install --frozen-lockfile'}
    use {'fannheyward/coc-markdownlint', run = 'yarn install --frozen-lockfile'}
    use {'neoclide/coc-json', run = 'yarn install --frozen-lockfile'}
    use {'neoclide/coc-css', run = 'yarn install --frozen-lockfile'}
    use {'dsznajder/vscode-es7-javascript-react-snippets', run = 'yarn install --frozen-lockfile && yarn compile'}
    use {'rafamadriz/friendly-snippets', run = 'yarn install --frozen-lockfile'}
    
    -- use 'vimwiki/vimwiki'
    --
    use 'chaoren/vim-wordmotion'
    use 'mg979/vim-visual-multi'
    use 'godlygeek/tabular'
    use 'plasticboy/vim-markdown'

       -- Autocomplete
    -- use 'hrsh7th/nvim-compe' -- apparantly non needed with coc
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
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- Status Line and Bufferline
    use 'glepnir/galaxyline.nvim'
    use 'romgrk/barbar.nvim'
    
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope-project.nvim'

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'
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
    use 'terrortylor/nvim-comment'
    use 'monaqa/dial.nvim'
    use 'junegunn/goyo.vim'
    use 'andymass/vim-matchup'
    use 'MattesGroeger/vim-bookmarks'
    use 'windwp/nvim-autopairs'
    use 'mbbill/undotree'

    -- Documentation Generator
    use {'kkoomen/vim-doge', run = ':call doge#install()'}

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
