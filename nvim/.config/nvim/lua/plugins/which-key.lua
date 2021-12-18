local wk = require("which-key");
local terminals = require("plugins.toggleterm")
local gitblame = require("plugins.gitblame")

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
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 5, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
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
    [";"] = { ":Dashboard" , 'home screen'},
    ['/'] = { "<Plug>CommentaryLine<cr>", 'comment' },
    e = { ":NvimTreeToggle<cr>", 'filetree' },
    f = { ":Files<cr>", 'find files' },
    M = { ':MarkdownPreviewToggle', 'markdown preview' },
    u = { ':UndotreeToggle', 'undo tree'  },
    -- TODO create entire treesitter section
    T = { ':TSHighlightCapturesUnderCursor', 'treesitter highlight'  },
    h = { '<C-W>s', 'split below' },
    v = { '<C-W>v', 'split right' },

    -- Actions
    a = {
        name = "actions",
        c = { ':ColorizerToggle<cr>', 'colorizer' },
        i = { ':IndentBlanklineToggle<cr>', 'toggle indent lines' },
        n = { ':set nonumber!<cr>', 'line-numbers' },
        -- @TODO fix
      --  s = { ':s/\%V\(.*\)\%V/"\1"/<cr>', 'surround' },
        r = { ':set norelativenumber!<cr>', 'relative line nums' },
        v = { ':Codi<cr>', 'virtual repl on' },
        V = { ':Codi!<cr>', 'virtual repl off' },
    },

    -- Buffer
    b = {
        name= "buffer",
        ['>'] = { ':BufferMoveNext<cr>', 'move next' },
        ['<'] = { ':BufferMovePrevious<cr>', 'move prev' },
        b = { ':BufferPick<cr>', 'pick buffer' },
        d = { ':BufferClose<cr>', 'delete-buffer' },
        n = { ':bnext<cr>', 'next-buffer' },
        p = { ':bprevious<cr>', 'previous-buffer' },
        ['?'] = { ':Buffers<cr>', 'fzf-buffer' },
    },

    -- CoC
    c = {
        name = "CoC",
        r = { '<Plug>(coc-rename)<cr>', 'rename' },
        f = { '<Plug>(coc-format-selected)<cr>', 'format' },
        a = { '<Plug>(coc-codeaction-selected)<cr>', 'code action selected' },
        c = { '<Plug>(coc-codeaction)<cr>', 'code action' },
        q = { '<Plug>(coc-fix-current)<cr>', 'quick fix' },
    },

    -- Search
    s = {
        name = 'search',
        ['.'] =  { ':Filetypes<cr>',  'filetypes' },
        d  =  { ':GFiles?<cr>',  'diff (git status)' },
        b  =  { ':Buffers<cr>',  'buffers' },
        B  =  { ':GBranches<cr>',  'git branches' },
        t  =  { ':Rg<cr>',  'text' },
        ['/']  =  { ':BLines<cr>',  'current buffer' },
        c  =  { ':Commits<cr>',  'commits' },
        p  =  { ':Commands<cr>',  'commands' },
        h  =  { ':Helptags<cr>',  'help' },
    },

    -- Fold
    -- @TODO see what's going on
    F = {
        name = "fold",
        O = { ':set foldlevel=20<cr>', 'open all' },
        C = { ':set foldlevel=0<cr>', 'close all' },
        c = { ':foldclose<cr>', 'close' },
        o = { ':foldopen<cr>', 'open' },
       ['1'] = { ':set foldlevel=1<cr>', 'level1' },
       ['2'] = { ':set foldlevel=2<cr>', 'level2' },
       ['3'] = { ':set foldlevel=3<cr>', 'level3' },
       ['4'] = { ':set foldlevel=4<cr>', 'level4' },
       ['5'] = { ':set foldlevel=5<cr>', 'level5' },
       ['6'] = { ':set foldlevel=6<cr>', 'level6' }
    },

    -- Git
    g = {
        name = "git",
        b = { gitblame.toggle, 'blame' },
        B = { ':GBrowse<cr>', 'browse' },
        d = { ':Gvdiffsplit<cr>', 'diff' },
        j = { ':NextHunk<cr>', 'next hunk' },
        k = { ':PrevHunk<cr>', 'prev hunk' },
        l = { ':Git log<cr>', 'log' },
        p = { '<Plug>(GitGutterPreviewHunk)<cr>', 'preview hunk' },
        r = { ':ResetHunk<cr>', 'reset hunk' },
        R = { ':ResetBuffer<cr>', 'reset buffer' },
        s = { '<Plug>(GitGutterStageHunk)<cr>', 'stage hunk' },
        S = { ':Gstatus<cr>', 'status' },
        u = { '<Plug>(GitGutterUndoHunk)<cr>', 'undo stage hunk' },
    },

    -- Gist
    G = {
        name = "gist",
        b = { ':Gist -b<cr>', 'post gist browser' },
        d = { ':Gist -d<cr>', 'delete gist' },
        e = { ':Gist -e<cr>', 'edit gist' },
        l = { ':Gist -l<cr>', 'list public gists' },
        s = { ':Gist -ls<cr>', 'list starred gists' },
        m = { ':Gist -m<cr>', 'post gist all buffers' },
        p = { ':Gist -P<cr>', 'post public gist ' },
        P = { ':Gist -p<cr>', 'post private gist ' },
        a = { ':Gist -a<cr>', 'post gist anon' },
    },

    -- Session
    S = {
        name = 'session',
        s = { ':SessionSave<cr>', 'save session' },
        l = { ':SessionLoad<cr>', 'load session' },
    },

    -- Terminal
    t = {
        name = "terminal",
        t = { terminals.toggle_hor, 'toggle' },
        v = { terminals.toggle_vert, 'vertical' },
        f = { terminals.toggle_float, 'float' },
        n = { terminals.toggle_node, 'node' },
        m = { terminals.toggle_npm, 'npm' },
        r = { terminals.toggle_ranger, 'ranger' },
        g = { terminals.toggle_git, 'git' },
    },
}

wk.register(mappings, { prefix = "<leader>"})
