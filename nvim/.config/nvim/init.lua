-- General mappings
require('nv-utils')
-- check if coc formats on save
-- require('autocommands')
require('settings')
require('keymappings')
require('colorscheme')

-- Plugins

require('plugins.packer')
require('plugins.autopairs')
require('plugins.barbar')
require('plugins.nvim-tree')
require('plugins.vim-commentary')
require('plugins.which-key')
require('plugins.toggleterm')
require('plugins.lualine')

require('nv-treesitter')
require('nv-emmet')
require('nv-quickscope')
-- require('nv-telescope')
require('nv-matchup')
require('nv-gitblame')
require('nv-nvim-peekup')
require('nv-dashboard')
require('nv-indentline')
require('nv-bookmark')


vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

vim.cmd('source ~/.config/nvim/vimscript/nv-coc/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/gitgutter/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/fzf/init.vim')
