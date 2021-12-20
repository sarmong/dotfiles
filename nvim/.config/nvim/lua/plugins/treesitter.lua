require("nvim-treesitter.configs").setup({
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = false,

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
  context_commentstring = { enable = true, config = { javascriptreact = { style_element = "{/*%s*/}" } } },
  -- @TODO I don't use other features from this module.
  -- consider finding separate smaller plugin for hightlight definitions (perhaps with native lsp)
  refactor = {
    highlight_definitions = { enable = true },
  },
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- disabled by default
vim.o.foldenable = false
