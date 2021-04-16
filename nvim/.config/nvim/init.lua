-- General mappings
require('plugins')
require('nv-utils')
-- check if coc formats on save
-- require('nv-autocommands')
require('settings')
require('keymappings')
require('colorscheme')
require('nv-galaxyline')

-- Plugins

-- require('nv-compe') -- apparantly non needed with coc
require('nv-nvimtree')
require('nv-treesitter')
require('nv-barbar')
require('nv-emmet')
require('nv-quickscope')
require('nv-autopairs')
require('nv-comment')
require('nv-rnvimr')
require('nv-telescope')
require('nv-floaterm')
require('nv-vim-rooter')
require('nv-matchup')
require('nv-hop')
require('nv-gitblame')
require('nv-nvim-peekup')
require('nv-dashboard')
require('nv-dial')
require('nv-nvim-dap')
require('nv-indentline')
require('nv-bookmark')
require('nv-doge')


-- Which Key (Hope to replace with Lua plugin someday)
vim.cmd('source ~/.config/nvim/vimscript/nv-whichkey/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

vim.cmd('source ~/.config/nvim/vimscript/nv-coc/init.vim')
-- vim.cmd('source ~/.config/nvim/vimscript/vimwiki/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/wordmotion/init.vim')
-- vim.cmd('source ~/.config/nvim/vimscript/nerdtree/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/gitgutter/init.vim')
