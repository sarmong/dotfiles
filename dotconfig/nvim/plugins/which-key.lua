local project = req("plugins.project")
local wk = req("which-key")
local colorscheme = req("settings.colorscheme")
local git = req("plugins.git").git
local gitsigns = req("plugins.git").gitsigns
local github = req("plugins.git").github
local lsp_fns = req("lsp.functions")
local alpha = req("plugins.alpha")
local nvim_tree = req("plugins.nvim-tree")
local tabline = req("plugins.tabline")
local spectre = req("plugins.spectre")
local colorizer = req("plugins.colorizer")
local true_zen = req("plugins.true_zen")
local refactoring = req("plugins.refactoring")
local hop = req("plugins.hop")

vim.opt.timeoutlen = 700

wk.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },

  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 5, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

local mappings = {
  [";"] = { alpha.open_home_page, "home screen" },
  ["/"] = { "<Plug>CommentaryLine<cr>", "comment" },
  e = { nvim_tree.toggle, "filetree" },
  f = { ":Telescope find_files hidden=true<cr>", "find files" },
  M = { ":MarkdownPreviewToggle<cr>", "markdown preview" },
  u = { ":UndotreeToggle<cr>", "undo tree" },
  p = { '"_dP', "super paste" },
  -- @TODO find another place for scratchpad
  -- p = { ":Scratch<cr>", "scratchpad" },
  h = { "<C-W>s", "split below" },
  v = { "<C-W>v", "split right" },
  ['"'] = { 'viw<esc>a"<esc>bi"<esc>lel', "surround" },
  ["'"] = { "viw<esc>a'<esc>bi'<esc>lel", "surround" },
  ["("] = { "viw<esc>a)<esc>bi(<esc>lel", "surround" },
  [")"] = { "viw<esc>a)<esc>bi(<esc>lel", "surround" },
  ["{"] = { "viw<esc>a}<esc>bi{<esc>lel", "surround" },
  ["}"] = { "viw<esc>a}<esc>bi{<esc>lel", "surround" },

  -- Actions
  a = {
    name = "actions",
    c = { colorizer.toggle, "colorizer" },
    i = { ":IndentBlanklineToggle<cr>", "toggle indent lines" },
    n = { ":set nonumber!<cr>", "line-numbers" },
    r = { ":set norelativenumber!<cr>", "relative line nums" },
    v = { ":Codi!!<cr>", "toggle virtual repl" },
    b = { colorscheme.toggle_background, "toggle background" },
    w = { ":setlocal wrap!<cr>", "toggle wrap" },
    h = { hop.word, "hop" },
    t = { ":AerialToggle<cr>", "code tree" },
  },

  -- Buffer
  b = {
    name = "buffer",
    n = { tabline.next_buf, "next buffer" },
    p = { tabline.prev_buf, "prev buffer" },
    -- close
    c = {
      name = "close",
      c = { tabline.close_all_but_current, "all but current" },
      p = { tabline.close_all_but_pinned, "all but pinned" },
      l = { tabline.close_all_to_the_left, "all to the left" },
      r = { tabline.close_all_to_the_right, "all to the right" },
    },
    o = {
      name = "order",
      d = { tabline.order_by_directory, "by directory" },
    },
  },

  -- Config
  c = {
    name = "config",
    v = { ":e $MYVIMRC<cr>", "nvim config" },
    s = {
      ":source $MYVIMRC<cr>:echo 'Loaded config'<cr>",
      "source nvim config",
    },
    -- Project
    p = {
      name = "project",
      m = { project.use_monorepo, "monorepo" },
      p = { project.use_package, "package" },
    },
  },

  -- Refactoring
  r = {
    name = "refactoring",
    i = { refactoring.inline_var, "inline variable" },
    b = {
      name = "block",
      e = { refactoring.extract_block, "extract block" },
      f = { refactoring.extract_block_to_file, "extract block to a file" },
    },
    p = { refactoring.print_debug, "print debug" },
    v = { refactoring.print_var, "print variable" },
    c = { refactoring.debug_cleanup, "debug cleanup" },
  },

  -- Search
  s = {
    name = "search",
    B = { ":Telescope git_branches<cr>", "git branches" },
    b = { ":Telescope buffers<cr>", "buffers" },
    d = {
      ":Telescope diagnostics bufnr=0<cr>",
      "document_diagnostics",
    },
    D = {
      ":Telescope diagnostics<cr>",
      "workspace_diagnostics",
    },
    f = { ":Telescope find_files hidden=true<cr>", "files" },
    c = { ":Telescope command_history<cr>", "history" },
    h = { ":Telescope help_tags<cr>", "vim help" },
    i = { ":Telescope media_files<cr>", "media files" },
    m = { ":Telescope marks<cr>", "marks" },
    M = { ":Telescope man_pages<cr>", "man_pages" },
    o = { ":Telescope vim_options<cr>", "vim_options" },
    t = {
      require("telescope").extensions.live_grep_args.live_grep_args,
      "text",
    },
    w = { ":Telescope grep_string<cr>", "word" },
    r = {
      name = "replace",
      s = { spectre.search, "search and replace" },
      w = { spectre.search_word, "search and replace word" },
    },
    R = { ":Telescope registers<cr>", "registers" },
    u = { ":Telescope colorscheme<cr>", "colorschemes" },
    p = { ":Telescope projects<cr>", "projects" },
    s = {
      function()
        require("telescope.builtin").resume({ initial_mode = "normal" })
      end,
      "previous search",
    },
  },

  -- Fold
  -- @TODO see what's going on
  F = {
    name = "fold",
    O = { ":set foldlevel=20<cr>", "open all" },
    C = { ":set foldlevel=0<cr>", "close all" },
    c = { ":foldclose<cr>", "close" },
    o = { ":foldopen<cr>", "open" },
    ["1"] = { ":set foldlevel=1<cr>", "level1" },
    ["2"] = { ":set foldlevel=2<cr>", "level2" },
    ["3"] = { ":set foldlevel=3<cr>", "level3" },
    ["4"] = { ":set foldlevel=4<cr>", "level4" },
    ["5"] = { ":set foldlevel=5<cr>", "level5" },
    ["6"] = { ":set foldlevel=6<cr>", "level6" },
  },

  -- Marks
  m = {
    a = {
      function()
        print(
          "Added "
            .. string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd(), "")
            .. " to the harpoon"
        )
        req("harpoon.mark").add_file()
      end,
      "add mark",
    },
    s = { req("harpoon.ui").toggle_quick_menu, "show marks" },
    n = { req("harpoon.ui").nav_next, "next mark" },
    p = { req("harpoon.ui").nav_prev, "prev mark" },
  },

  -- Git
  g = {
    name = "git",
    b = { git.toggle_blame, "blame" },
    B = { github.open_file, "browse" },
    d = { git.open_diff_vsplit, "diff" },
    j = { gitsigns.next_hunk, "next hunk" },
    k = { gitsigns.prev_hunk, "prev hunk" },
    l = { git.show_log, "log" },
    r = { gitsigns.reset_hunk, "reset hunk" },
    R = { gitsigns.reset_buffer, "reset buffer" },
    s = { gitsigns.stage_hunk, "stage hunk" },
    S = { git.show_status, "status" },
    u = { gitsigns.undo_stage_hunk, "undo stage hunk" },
    w = { gitsigns.toggle_word_diff, "toggle word diff" },
    p = { gitsigns.preview_hunk, "preview_hunk" },
    o = { github.open_repo, "open repo" },
    O = { github.open_line_url, "open line url" },
    y = { github.yank_repo, "yank repo url" },
    Y = { github.yank_line_url, "yank line url" },
    n = { git.open_neogit, "neogit" },
  },

  -- LSP
  l = {
    name = "LSP",
    F = { lsp_fns.format, "format" },
    e = { lsp_fns.enable_format_on_save, "enable format on save" },
    d = { lsp_fns.disable_format_on_save, "disable format on save" },
    t = { lsp_fns.go_to_type_definition, "go to type definition" },
    s = { lsp_fns.go_to_source_definition, "go to source" },
    r = { lsp_fns.rename, "rename" },
    a = { lsp_fns.code_action, "action" },
    f = { lsp_fns.open_float, "open float" },
    Q = { lsp_fns.set_loc_list, "set loc list" },
    q = { lsp_fns.fix_all, "quickfix all" },
    v = { lsp_fns.toggle_virtual_text, "toggle virtual text" },
    i = { lsp_fns.add_missing_imports, "add missing imports" },
    o = { lsp_fns.organize_imports, "organize imports" },
    R = { lsp_fns.rename_file, "rename file" },
    u = { lsp_fns.remove_unused, "remove unused" },
  },

  -- True Zen
  z = {
    name = "zen",
    a = { true_zen.toggle_ataraxis, "ataraxis" },
    f = { true_zen.toggle_focus, "focus" },
  },
}

wk.register(mappings, { prefix = "<leader>", mode = "n" })

wk.register(
  vim.tbl_extend("force", mappings, {
    ['"'] = { '<esc>`>a"<esc>`<i"<esc>gvll', "surround" },
    ["'"] = { "<esc>`>a'<esc>`<i'<esc>gvll", "surround" },
    ["("] = { "<esc>`>a)<esc>`<i(<esc>gvll", "surround" },
    [")"] = { "<esc>`>a)<esc>`<i(<esc>gvll", "surround" },
    ["{"] = { "<esc>`>a}<esc>`<i{<esc>gvll", "surround" },
    ["}"] = { "<esc>`>a}<esc>`<i{<esc>gvll", "surround" },

    -- Search
    s = vim.tbl_extend("force", mappings.s, {
      t = { "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", "text" },
    }),

    -- Refactoring
    r = {
      name = "refactoring",

      e = { refactoring.extract_fn, "extract function" },
      f = { refactoring.extract_fn_to_file, "extract function to a file" },
      v = { refactoring.extract_var, "extract variable" },
      i = { refactoring.inline_var, "inline variable" },
    },
  }),
  { prefix = "<leader>", mode = "v" }
)