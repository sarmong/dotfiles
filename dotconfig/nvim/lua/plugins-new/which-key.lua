return {
  "folke/which-key.nvim",
  config = function()
    local wk = req("which-key")
    local colorscheme = req("settings.colorscheme")
    local fns = req("modules.functions")

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
      hidden = {
        "<silent>",
        "<cmd>",
        "<Cmd>",
        "<CR>",
        "call",
        "lua",
        "^:",
        "^ ",
      }, -- hide mapping boilerplate
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
      M = { ":MarkdownPreviewToggle<cr>", "markdown preview" },
      u = { ":UndotreeToggle<cr>", "undo tree" },
      P = { '"_dP', "super paste" },
      -- @TODO find another place for scratchpad
      -- p = { ":Scratch<cr>", "scratchpad" },
      h = { "<C-W>s", "split below" },
      k = { "K", "view help" },
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
        i = { ":IndentBlanklineToggle<cr>", "toggle indent lines" },
        n = { ":set nonumber!<cr>", "line-numbers" },
        r = { ":set norelativenumber!<cr>", "relative line nums" },
        v = { ":Codi!!<cr>", "toggle virtual repl" },
        b = { colorscheme.toggle_background, "toggle background" },
        w = { ":setlocal wrap!<cr>", "toggle wrap" },
        s = { fns.toggle_signcolumn, "toggle signcolumn" },
        f = { fns.toggle_foldcolumn, "toggle foldcolumn" },
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

      s = {
        name = "search",
      },

      x = {
        x = { "<:!chmod +x %<CR>", "make executable" },
        c = { ":g/console.log/d<CR>:noh<CR>", "Remove console.logs" },
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

      p = {
        name = "play macro",
        i = { "0cwimport<ESC>f=cf(from <ESC>f)x", "change requireJS to ESM" },
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
      }),
      { prefix = "<leader>", mode = "v" }
    )
  end,
}
