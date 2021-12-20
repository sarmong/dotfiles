-- @TODO add some other options to whichKey

vim.api.nvim_set_keymap(
  "n",
  "<TAB>",
  ":BufferNext<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<S-TAB>",
  ":BufferPrevious<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-,>",
  ":BufferMovePrevious<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-.>",
  ":BufferMoveNext<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-p>",
  ":BufferPin<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<S-x>",
  ":BufferClose<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-w>",
  ":w<CR>:BufferClose<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<A-1>",
  ":BufferGoto 1<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-2>",
  ":BufferGoto 2<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-3>",
  ":BufferGoto 3<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-4>",
  ":BufferGoto 4<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-5>",
  ":BufferGoto 5<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-6>",
  ":BufferGoto 6<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-7>",
  ":BufferGoto 7<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-8>",
  ":BufferGoto 8<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-9>",
  ":BufferGoto 9<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-0>",
  ":BufferPick<CR>",
  { noremap = true, silent = true }
)

vim.g.bufferline = {
  icons = "both",
}

-- @TODO use this commands to open/close nvim-tree
local tree = {}
tree.open = function()
  require("bufferline.state").set_offset(31, "FileTree")
  require("nvim-tree").find_file(true)
end

tree.close = function()
  require("bufferline.state").set_offset(0)
  require("nvim-tree").close()
end

return tree
