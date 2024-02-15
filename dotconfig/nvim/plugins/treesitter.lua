local parsers = req("nvim-treesitter.parsers")

req("nvim-treesitter.configs").setup({
  ensure_installed = { --  "all" or a list of languages
    "astro",
    "bash",
    "c",
    "comment",
    "css",
    "dockerfile",
    "go",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "org",
    -- "proto",
    "python",
    "query",
    "rasi",
    "regex",
    "rust",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
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
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- disabled by default
vim.o.foldenable = false

-- Use bash treesitter for zsh filetypes
local ft_to_lang = parsers.ft_to_lang
parsers.ft_to_lang = function(ft)
  if ft == "zsh" then
    return "bash"
  end
  return ft_to_lang(ft)
end

vim.g.skip_ts_context_commentstring_module = true
-- @TODO this plugins integrades with commentary by default.
-- And only with gc. That's why it does'nt work with custom mappings
req("ts_context_commentstring").setup({
  enable = true,
  enable_autocmd = false,
  config = { javascriptreact = { style_element = "{/*%s*/}" } },
})
req("treesitter-context").setup({
  enable = true,
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
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
