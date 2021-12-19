-- @TODO figure out why this doesn't work for jsx
-- or extend numToStr/Comment.nvim
-- to comment jsx use `gcc`
-- for some reason in vim _ and / are swapped
vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>CommentaryLine", { noremap = false, silent = true })
