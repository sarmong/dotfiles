-- General mappings
require("nv-utils")
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
require("plugins.gitgutter")
require("plugins.fzf")

-- LSP
require("plugins.lsp")

-- require('plugins.archive.telescope')

vim.cmd("source ~/.config/nvim/vimscript/functions.vim")

-- vim.cmd('source ~/.config/nvim/vimscript/nv-coc/init.vim')
