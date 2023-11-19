req("ibl").setup({
  indent = {
    char = "▏",
  },
  exclude = {
    buftypes = { "terminal" },
    filetypes = {
      "man",
      "help",
      "alpha",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "qf",
    },
  },
  scope = {
    enabled = true,
  },
  -- show_current_context_start = true,
})

-- Where the hell does all of this go in v3???
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_context_patterns = {
  "class",
  "return",
  "function",
  "method",
  "^if",
  "^while",
  "jsx_element",
  "^for",
  "^object",
  "^table",
  "block",
  "arguments",
  "if_statement",
  "else_clause",
  "jsx_element",
  "jsx_self_closing_element",
  "try_statement",
  "catch_clause",
  "import_statement",
  "operation_type",
}
