local tree_cb = require("nvim-tree.config").nvim_tree_callback
local nvim_tree = require("nvim-tree")

vim.g.nvim_tree_git_hl = 1 --0 by default, will enable file highlight for git attributes (can be used without the icons).
-- @TODO Check why not working
vim.g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
vim.g.nvim_tree_group_empty = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_special_files = {
  ["README.md"] = 1,
  ["Makefile"] = 1,
  ["package.json"] = 1,
} -- List of filenames that gets highlighted with NvimTreeSpecialFile

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local keymappings = {
  -- mappings
  { key = { "<CR>", "l", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
  { key = { "<C-]>", "<2-RightMouse>" }, cb = tree_cb("cd") },
  { key = "v", cb = tree_cb("vsplit") },
  { key = "s", cb = tree_cb("split") },
  { key = { "h", "<BS>", "<S-CR>" }, cb = tree_cb("close_node") },
  { key = "<Tab>", cb = tree_cb("preview") },
  { key = "I", cb = tree_cb("toggle_git_ignored") },
  { key = "H", cb = tree_cb("toggle_dotfiles") },
  { key = "R", cb = tree_cb("refresh") },
  { key = "a", cb = tree_cb("create") },
  -- @TODO see if trash can be used for folders
  { key = "d", cb = tree_cb("trash") },
  { key = "D", cb = tree_cb("remove") },
  { key = "r", cb = tree_cb("rename") },
  { key = "<C-r>", cb = tree_cb("full_rename") },
  { key = "x", cb = tree_cb("cut") },
  { key = "c", cb = tree_cb("copy") },
  { key = "p", cb = tree_cb("paste") },
  { key = "[c", cb = tree_cb("prev_git_item") },
  { key = "]c", cb = tree_cb("next_git_item") },
  { key = "-", cb = tree_cb("dir_up") },
  { key = "q", cb = tree_cb("close") },
  { key = "P", cb = tree_cb("parent_node") },
  { key = "y", cb = tree_cb("copy_name") },
  { key = "Y", cb = tree_cb("copy_path") },
  { key = "?", cb = tree_cb("toggle_help") },
  { key = "W", action = "collapse_all" },
  { key = "s", cb = tree_cb("system_open") },
  { key = "S", cb = tree_cb("search_node") },
  { key = ".", cb = tree_cb("run_file_command") },
  { key = "K", cb = tree_cb("toggle_file_info") },
}

nvim_tree.setup({
  disable_netrw = false,
  hijack_netrw = false,
  hijack_cursor = true,
  filters = {
    dotfiles = true,
    exclude = { ".config", ".local" },
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    mappings = {
      list = keymappings,
    },
  },
  renderer = {
    indent_markers = {
      enable = true, -- this option shows indent markers when folders are open
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
})

-- Close vim if nvim-tree is the last buffer
vim.api.nvim_exec(
  [[ autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif ]],
  false
)

return {
  toggle = function()
    nvim_tree.toggle()
  end,
}
