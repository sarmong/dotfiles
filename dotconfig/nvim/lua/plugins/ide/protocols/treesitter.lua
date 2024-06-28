Plugin({
  "nvim-treesitter/nvim-treesitter",
  hooks = {
    post_checkout = cmd.bind("TSUpdate"),
  },
})

Plugin("p00f/nvim-ts-rainbow") -- rainbow parantheses
Plugin("windwp/nvim-ts-autotag")
Plugin("nvim-treesitter/nvim-treesitter-refactor")
Plugin("nvim-treesitter/nvim-treesitter-textobjects")
Plugin("nvim-treesitter/nvim-treesitter-context")
Plugin("JoosepAlviste/nvim-ts-context-commentstring")

req("treesitter-context").setup({
  enable = true,
  max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 30,
  patterns = {
    default = {
      "class",
      "function",
      "method",
      "for",
      "if",
      "switch",
    },
  },
  -- [!] The options below are exposed but shouldn't require your attention,
  --     you can safely ignore them.
  zindex = 20, -- The Z-index of the context window
})

local opts = {
  ensure_installed = req("plugins.ide.contrib").state.ts_parsers,
  highlight = {
    enable = true, -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "org" },

    disable = function()
      return vim.api.nvim_buf_line_count(0) > 4000
        or vim.fn.getline(1):len() > 200
    end,
  },

  textobjects = {
    -- swappable queries can be found here
    -- https://github.com/atchim/dotsoup/tree/main/nvim/queries
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ts"] = "@swappable",
      },
      swap_previous = {
        ["<leader>tS"] = "@swappable",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
        },
      },
    },
  },

  autotag = { enable = true },
  -- @TODO causes file to be readonly, seek alternative
  rainbow = {
    enable = false,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  -- @TODO I don't use other features from this module.
  -- consider finding separate smaller plugin for hightlight definitions (perhaps with native lsp)
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
  },
}
req("nvim-treesitter.configs").setup(opts)

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- disable at startup
vim.o.foldenable = false

-- Skip backwards compatibility routines and speed up loading
vim.g.skip_ts_context_commentstring_module = true

-- @TODO this plugins integrades with commentary by default.
-- And only with gc. That's why it does'nt work with custom mappings
req("ts_context_commentstring").setup({
  enable = true,
  enable_autocmd = false,
  config = { javascriptreact = { style_element = "{/*%s*/}" } },
})
