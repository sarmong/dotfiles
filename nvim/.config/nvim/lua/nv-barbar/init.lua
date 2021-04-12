vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-x>', ':w<CR>:BufferClose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-w>', ':w<CR>:BufferClose<CR>', { noremap = true, silent = true })
