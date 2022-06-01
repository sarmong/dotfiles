local parsers = require("nvim-treesitter.parsers")

require("orgmode").setup_ts_grammar()

require("nvim-treesitter.configs").setup({
  ensure_installed = { --  "all" or a list of languages
    "bash",
    "c",
    "comment",
    "css",
    "dockerfile",
    "help",
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
    "org",
    -- "proto",
    "python",
    "query",
    "rasi",
    "regex",
    "rust",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    --   disable = { "org" },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "markdown", "org" },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
      -- @TODO doesn't word, consider custom
      --swap = {
      --     enable = true,
      --     swap_next = { ['<leader>ts'] = '@swappable' },
      --     swap_previous = { ['<leader>tS'] = '@swappable' }
      -- }
      -- затем надо добавить capture group'у в textobjects.scm, открываешь нужный файлтайп, делаешь :TSEditQueryUserAfter textobjects и пишешь query, например для lua у меня вот такое:
      -- (field) @swappable
      -- (arguments (_) @swappable)
      -- swap = {
      --   enable = true,
      --   swap_next = {
      --     ["]m"] = "@parameter.inner",
      --   },
      --   swap_previous = {
      --     ["[m"] = "@parameter.inner",
      --   },
      -- },
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
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  -- @TODO this plugins integrades with commentary by default.
  -- And only with gc. That's why it does'nt work with custom mappings
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = { javascriptreact = { style_element = "{/*%s*/}" } },
  },
  -- @TODO I don't use other features from this module.
  -- consider finding separate smaller plugin for hightlight definitions (perhaps with native lsp)
  refactor = {
    highlight_definitions = { enable = true },
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

require("treesitter-context").setup({
  enable = true,
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
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
