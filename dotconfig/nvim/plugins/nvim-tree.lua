local nvim_tree = req("nvim-tree")
local api = req("nvim-tree.api")

local function on_attach(bufnr)
  local function m(lhs, rhs, desc)
    map("n", lhs, rhs, {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
    })
  end

  -- Default mappings
  m("<C-]>", api.tree.change_root_to_node, "CD")
  m("<C-e>", api.node.open.replace_tree_buffer, "Open: In Place")
  m("<C-k>", api.node.show_info_popup, "Info")
  m("<C-r>", api.fs.rename_sub, "Rename: Omit Filename")
  m("<C-t>", api.node.open.tab, "Open: New Tab")
  m("<C-v>", api.node.open.vertical, "Open: Vertical Split")
  m("<C-x>", api.node.open.horizontal, "Open: Horizontal Split")
  m("<BS>", api.node.navigate.parent_close, "Close Directory")
  m("<CR>", api.node.open.edit, "Open")
  m("<Tab>", api.node.open.preview, "Open Preview")
  m(">", api.node.navigate.sibling.next, "Next Sibling")
  m("<", api.node.navigate.sibling.prev, "Previous Sibling")
  m(".", api.node.run.cmd, "Run Command")
  m("-", api.tree.change_root_to_parent, "Up")
  m("a", api.fs.create, "Create")
  m("bd", api.marks.bulk.delete, "Delete Bookmarked")
  m("bmv", api.marks.bulk.move, "Move Bookmarked")
  m("B", api.tree.toggle_no_buffer_filter, "Toggle No Buffer")
  m("c", api.fs.copy.node, "Copy")
  m("C", api.tree.toggle_git_clean_filter, "Toggle Git Clean")
  m("[c", api.node.navigate.git.prev, "Prev Git")
  m("]c", api.node.navigate.git.next, "Next Git")
  m("d", api.fs.remove, "Delete")
  m("D", api.fs.trash, "Trash")
  m("E", api.tree.expand_all, "Expand All")
  m("e", api.fs.rename_basename, "Rename: Basename")
  m("]e", api.node.navigate.diagnostics.next, "Next Diagnostic")
  m("[e", api.node.navigate.diagnostics.prev, "Prev Diagnostic")
  m("F", api.live_filter.clear, "Clean Filter")
  m("f", api.live_filter.start, "Filter")
  m("g?", api.tree.toggle_help, "Help")
  m("gy", api.fs.copy.absolute_path, "Copy Absolute Path")
  m("H", api.tree.toggle_hidden_filter, "Toggle Dotfiles")
  m("I", api.tree.toggle_gitignore_filter, "Toggle Git Ignore")
  m("J", api.node.navigate.sibling.last, "Last Sibling")
  m("K", api.node.navigate.sibling.first, "First Sibling")
  m("m", api.marks.toggle, "Toggle Bookmark")
  m("o", api.node.open.edit, "Open")
  m("O", api.node.open.no_window_picker, "Open: No Window Picker")
  m("p", api.fs.paste, "Paste")
  m("P", api.node.navigate.parent, "Parent Directory")
  m("q", api.tree.close, "Close")
  m("r", api.fs.rename, "Rename")
  m("R", api.tree.reload, "Refresh")
  m("s", api.node.run.system, "Run System")
  m("S", api.tree.search_node, "Search")
  m("U", api.tree.toggle_custom_filter, "Toggle Hidden")
  m("W", api.tree.collapse_all, "Collapse")
  m("x", api.fs.cut, "Cut")
  m("y", api.fs.copy.filename, "Copy Name")
  m("Y", api.fs.copy.relative_path, "Copy Relative Path")
  m("<2-LeftMouse>", api.node.open.edit, "Open")
  m("<2-RightMouse>", api.tree.change_root_to_node, "CD")

  -- Custom mappings
  m("o", api.node.open.tab, "Open: New Tab")
  m("<CR>", api.node.open.edit, "Open")
  m("l", api.node.open.edit, "Open")
  m("<2-LeftMouse>", api.node.open.edit, "Open")
  m("<Tab>", api.node.open.preview, "Open Preview")
  m("<C-]>", api.tree.change_root_to_node, "CD")
  m("<2-RightMouse>", api.tree.change_root_to_node, "CD")
  m("v", api.node.open.vertical, "Open: Vertical Split")
  m("s", api.node.open.horizontal, "Open: Horizontal Split")
  m("h", api.node.navigate.parent_close, "Close Directory")
  m("<BS>", api.node.navigate.parent_close, "Close Directory")
  m("<S-CR>", api.node.navigate.parent_close, "Close Directory")
  m("I", api.tree.toggle_gitignore_filter, "Toggle Git Ignore")
  m("H", api.tree.toggle_hidden_filter, "Toggle Dotfiles")
  m("R", api.tree.reload, "Refresh")
  m("a", api.fs.create, "Create")
  m("d", api.fs.trash, "Trash")
  m("D", api.fs.remove, "Delete")
  m("r", api.fs.rename, "Rename")
  m("<C-r>", api.fs.rename_sub, "Rename: Omit Filename")
  m("x", api.fs.cut, "Cut")
  m("c", api.fs.copy.node, "Copy")
  m("p", api.fs.paste, "Paste")
  m("[c", api.node.navigate.git.prev, "Prev Git")
  m("]c", api.node.navigate.git.next, "Next Git")
  m("-", api.tree.change_root_to_parent, "Up")
  m("q", api.tree.close, "Close")
  m("P", api.node.navigate.parent, "Parent Directory")
  m("y", api.fs.copy.filename, "Copy Name")
  m("Y", api.fs.copy.relative_path, "Copy Relative Path")
  m("?", api.tree.toggle_help, "Help")
  m("W", api.tree.collapse_all, "Collapse")
  m("s", api.node.run.system, "Run System")
  m("S", api.tree.search_node, "Search")
  m(".", api.node.run.cmd, "Run Command")
  m("K", api.node.show_info_popup, "Info")
end

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  filters = {
    dotfiles = true,
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
    debounce_delay = 100,
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
  on_attach = on_attach,
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
    api.tree.toggle()
  end,
}
