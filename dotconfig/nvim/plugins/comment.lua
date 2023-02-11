-- for some reason in vim _ and / are swapped
vim.api.nvim_set_keymap(
  "n",
  "<C-_>",
  "<Plug>(comment_toggle_current_linewise)",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "v",
  "<C-_>",
  "<Plug>(comment_toggle_linewise_visual)",
  { noremap = true, silent = true }
)

-- taken from https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
req("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
