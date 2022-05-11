-- @TODO add some other options to whichKey

local fns = {
  next = function()
    vim.cmd("BufferNext")
  end,

  prev = function()
    vim.cmd("BufferPrevious")
  end,

  move_next = function()
    vim.cmd("BufferMoveNext")
  end,

  move_prev = function()
    vim.cmd("BufferMovePrevious")
  end,

  pin = function()
    vim.cmd("BufferPin")
  end,

  close = function()
    vim.cmd("BufferClose")
  end,

  go_to = function(n)
    vim.cmd("BufferGoto " .. n)
  end,

  pick = function()
    vim.cmd("BufferPick")
  end,

  close_all_but_current = function()
    vim.cmd("BufferCloseAllButCurrent")
  end,

  close_all_but_pinned = function()
    vim.cmd("BufferCloseAllButPinned")
  end,

  close_all_to_the_left = function()
    vim.cmd("BufferCloseBuffersLeft")
  end,

  close_all_to_the_right = function()
    vim.cmd("BufferCloseBuffersRight")
  end,

  order_by_directory = function()
    vim.cmd("BufferOrderByDirectory")
  end,
}

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

return fns
