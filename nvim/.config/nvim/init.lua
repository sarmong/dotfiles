-- General mappings
require("nv-utils")
-- check if coc formats on save
-- require('autocommands')
require("settings")
require("keymappings")
require("colorscheme")

-- Plugins

require("plugins.packer")
require("plugins.autopairs")
require("plugins.barbar")
require("plugins.nvim-tree")
require("plugins.vim-commentary")
require("plugins.which-key")
require("plugins.toggleterm")
require("plugins.lualine")
require("plugins.quick-scope")
require("plugins.matchup")
require("plugins.alpha")
require("plugins.indent-blankline")
-- require('plugins.colorizer')
require("plugins.gitblame")
require("plugins.treesitter")

-- LSP
require("plugins.lsp")

-- require('nv-telescope')

vim.cmd("source ~/.config/nvim/vimscript/functions.vim")

-- vim.cmd('source ~/.config/nvim/vimscript/nv-coc/init.vim')
vim.cmd("source ~/.config/nvim/vimscript/gitgutter/init.vim")
vim.cmd("source ~/.config/nvim/vimscript/fzf/init.vim")
