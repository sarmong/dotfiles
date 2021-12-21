-- Unmap space and set leader key to space
vim.api.nvim_set_keymap(
  "n",
  "<Space>",
  "<NOP>",
  { noremap = true, silent = true }
)
vim.g.mapleader = " "

-- better window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- save doc using Ctrl+s. If this doesn't work add this two lines to bash_profile: (or just the second)
-- bind -r '\C-s'
-- stty -ixon
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:w<CR>", { silent = true })

-- start fzf
vim.api.nvim_set_keymap("n", "<C-p>", ":GFiles<CR>", { silent = true })

-- turn off search highlights until next search
vim.api.nvim_set_keymap(
  "n",
  "<esc><esc>",
  ":noh<CR>",
  { noremap = true, silent = true }
)

-- @TODO transform to lua functions
-- Terminal window navigation
vim.cmd([[
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
]])

-- @TODO fix this - interferes with visual-multi plugin
-- resize with arrows
vim.cmd([[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]])

-- better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Not sure if I need this.
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap(
  "x",
  "K",
  ":move '<-2<CR>gv-gv",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "x",
  "J",
  ":move '>+1<CR>gv-gv",
  { noremap = true, silent = true }
)
