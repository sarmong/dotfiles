local nvim_tree = req("nvim-tree")

local keymappings = {
  -- mappings
  { key = { "o" }, action = "tabnew" },
  { key = { "<CR>", "l", "<2-LeftMouse>" }, action = "edit" },
  { key = "<Tab>", action = "preview" },
  { key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
  { key = "v", action = "vsplit" },
  { key = "s", action = "split" },
  { key = { "h", "<BS>", "<S-CR>" }, action = "close_node" },
  { key = "I", action = "toggle_git_ignored" },
  { key = "H", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "trash" },
  { key = "D", action = "remove" },
  { key = "r", action = "rename" },
  { key = "<C-r>", action = "full_rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "[c", action = "prev_git_item" },
  { key = "]c", action = "next_git_item" },
  { key = "-", action = "dir_up" },
  { key = "q", action = "close" },
  { key = "P", action = "parent_node" },
  { key = "y", action = "copy_name" },
  { key = "Y", action = "copy_path" },
  { key = "?", action = "toggle_help" },
  { key = "W", action = "collapse_all" },
  { key = "s", action = "system_open" },
  { key = "S", action = "search_node" },
  { key = ".", action = "run_file_command" },
  { key = "K", action = "toggle_file_info" },
}

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  filters = {
    dotfiles = true,
    exclude = { ".config", ".local" },
  },
  -- needed for project.nvim
  update_cwd = true,
  -- @TODO unknown option
  -- respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    side = "right",
    width = 50,
    mappings = {
      list = keymappings,
    },
  },
  renderer = {
    highlight_git = true, -- will enable file highlight for git attributes (can be used without the icons).
    highlight_opened_files = "icon", -- none, icon, name, all -- will enable folder and file icon highlight for opened files/directories.
    group_empty = true, -- compact folders that only contain a single folder into one node in the file tree
    indent_markers = {
      enable = true, -- this option shows indent markers when folders are open
    },
    special_files = {
      ["README.md"] = 1,
      ["Makefile"] = 1,
      ["package.json"] = 1,
    }, -- List of filenames that gets highlighted with NvimTreeSpecialFile
    icons = {
      glyphs = {
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
      },
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
  actions = {
    open_file = {
      window_picker = {
        picker = req("window-picker").pick_window,
      },
    },
  },
})

-- Close vim if nvim-tree is the last buffer
autocmd("BufEnter", {
  nested = true,
  group = "NvimTree - close vim",
  callback = function()
    if
      #vim.api.nvim_list_wins() == 1
      and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
    then
      vim.cmd("quit")
    end
  end,
})

return {
  toggle = function()
    nvim_tree.toggle()
  end,
}
