local wk = require("which-key")
local terminals = require("plugins.toggleterm")
local git = require("plugins.git").git
local gitsigns = require("plugins.git").gitsigns
local github = require("plugins.git").github
local lsp_fns = require("lsp.functions")
local alpha = require("plugins.alpha")
local nvim_tree = require("plugins.nvim-tree")
local buffer = require("plugins.bufferline")
local spectre = require("plugins.spectre")
local colorizer = require("plugins.colorizer")
local true_zen = require("plugins.true_zen")

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
  -- TODO create entire treesitter section
  T = { ":TSHighlightCapturesUnderCursor<cr>", "treesitter highlight" },
  h = { "<C-W>s", "split below" },
  v = { "<C-W>v", "split right" },

  -- Actions
  a = {
    name = "actions",
    c = { colorizer.toggle, "colorizer" },
    i = { ":IndentBlanklineToggle<cr>", "toggle indent lines" },
    n = { ":set nonumber!<cr>", "line-numbers" },
    -- @TODO fix
    --  s = { ':s/\%V\(.*\)\%V/"\1"/<cr>', 'surround' },
    r = { ":set norelativenumber!<cr>", "relative line nums" },
    v = { ":Codi<cr>", "virtual repl on" },
    V = { ":Codi!<cr>", "virtual repl off" },
  },

  -- Buffer
  b = {
    name = "buffer",
    -- close
    c = {
      name = "close",
      c = { buffer.close_all_but_current, "all but current" },
      p = { buffer.close_all_but_pinned, "all but pinned" },
      l = { buffer.close_all_to_the_left, "all to the left" },
      r = { buffer.close_all_to_the_right, "all to the right" },
    },
    o = {
      name = "order",
      d = { buffer.order_by_directory, "by directory" },
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
  },

  -- Search
  s = {
    name = "search",
    B = { ":Telescope git_branches<cr>", "git branches" },
    d = {
      ":Telescope diagnostics bufnr=0<cr>",
      "document_diagnostics",
    },
    D = {
      ":Telescope diagnostics<cr>",
      "workspace_diagnostics",
    },
    f = { ":Telescope find_files hidden=true<cr>", "files" },
    h = { ":Telescope command_history<cr>", "history" },
    i = { ":Telescope media_files<cr>", "media files" },
    m = { ":Telescope marks<cr>", "marks" },
    M = { ":Telescope man_pages<cr>", "man_pages" },
    o = { ":Telescope vim_options<cr>", "vim_options" },
    t = { ":Telescope live_grep<cr>", "text" },
    r = {
      name = "replace",
      s = { spectre.search, "search and replace" },
      w = { spectre.search_word, "search and replace word" },
    },
    R = { ":Telescope registers<cr>", "registers" },
    w = { ":Telescope file_browser<cr>", "buf_fuz_find" },
    u = { ":Telescope colorscheme<cr>", "colorschemes" },
    p = { ":Telescope project<cr>", "projects" },
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
  },

  -- Gist
  G = {
    name = "gist",
    b = { ":Gist -b<cr>", "post gist browser" },
    d = { ":Gist -d<cr>", "delete gist" },
    e = { ":Gist -e<cr>", "edit gist" },
    l = { ":Gist -l<cr>", "list public gists" },
    s = { ":Gist -ls<cr>", "list starred gists" },
    m = { ":Gist -m<cr>", "post gist all buffers" },
    p = { ":Gist -P<cr>", "post public gist " },
    P = { ":Gist -p<cr>", "post private gist " },
    a = { ":Gist -a<cr>", "post gist anon" },
  },

  -- Terminal
  t = {
    name = "terminal",
    t = { terminals.toggle_hor, "toggle" },
    v = { terminals.toggle_vert, "vertical" },
    f = { terminals.toggle_float, "float" },
    n = { terminals.toggle_node, "node" },
    m = { terminals.toggle_npm, "npm" },
    r = { terminals.toggle_ranger, "ranger" },
    g = { terminals.toggle_git, "git" },
  },

  -- LSP
  l = {
    name = "LSP",
    F = { lsp_fns.format, "format" },
    e = { lsp_fns.enable_format_on_save, "enable format on save" },
    d = { lsp_fns.disable_format_on_save, "disable format on save" },
    t = { lsp_fns.go_to_type_definition, "go to type definition" },
    r = { lsp_fns.rename, "rename" },
    a = { lsp_fns.code_action, "action" },
    f = { lsp_fns.open_float, "open float" },
    q = { lsp_fns.set_loc_list, "set loc list" },
    v = { lsp_fns.enable_virtual_text, "virtual text on" },
    V = { lsp_fns.disable_virtual_text, "virtual text off" },
  },

  -- True Zen
  z = {
    name = "zen",
    a = { true_zen.toggle_ataraxis, "ataraxis" },
    f = { true_zen.toggle_focus, "focus" },
  },
}

wk.register(mappings, { prefix = "<leader>", mode = "n" })
wk.register(mappings, { prefix = "<leader>", mode = "v" })
