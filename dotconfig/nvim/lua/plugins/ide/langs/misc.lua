local contrib = req("plugins.ide.contrib")

-- Ansible
contrib.mason("ansible-language-server", "ansible-lint")
contrib.lsp("ansiblels")
contrib.formatters("yaml.ansible", "ansible-lint")

-- YAML
contrib.mason("prettierd", "prettierd")
contrib.formatters("yaml", { "prettierd", "prettier" })
contrib.ts_parsers("yaml")

-- Clang
contrib.mason("clangd")
contrib.lsp("clangd")
contrib.ts_parsers("c")

-- VimScript
contrib.mason("vim-language-server")
contrib.lsp("vimls")
contrib.ts_parsers("vim", "vimdoc")

-- JSON
contrib.mason("prettierd", "prettierd")
contrib.formatters({ "json", "jsonc" }, { "prettierd", "prettier" })
contrib.ts_parsers("json", "json5", "jsonc")

-- HTMX
-- TODO: lsp.buf.hover merges output from all lsps in 0.11
-- htmx-lsp errors and thus all hover doesn't work in ts/js
-- contrib.mason("htmx-lsp")
-- contrib.lsp("htmx", function()
--   return {
--     filetypes = {
--       "html",
--       "templ",
--       "javascriptreact",
--       "typescriptreact",
--       "astro",
--     },
--   }
-- end)

-- Other TS parser
contrib.ts_parsers(
  "awk",
  "comment",
  "csv",
  "dockerfile",
  "http",
  "java",
  "jq",
  "latex",
  "make",
  "proto",
  "pug",
  "query",
  "rasi",
  "regex",
  "rust",
  "sql",
  "toml",
  "tsv"
)

contrib.mason("tree-sitter-cli") -- required by latex ts parser

-- Other prettier fts
contrib.formatters({ "graphql", "handlebars" }, { "prettierd", "prettier" })

Plugin("sarmong/lf-vim") -- TODO: remove when in stable - https://github.com/neovim/neovim/pull/30801
Plugin("sarmong/newsboat.vim")
Plugin("kovetskiy/sxhkd-vim")
Plugin("sarmong/conky-syntax.vim")
Plugin("elkowar/yuck.vim")
Plugin("fladson/vim-kitty")

contrib.ts_parsers("devicetree")
autocmd("BufEnter", {
  pattern = "*.keymap",
  group = "dts",
  command = "TSBufDisable highlight"
})
Plugin("martinlroth/vim-devicetree")
Plugin("codethread/qmk.nvim")
req("qmk").setup({
  name = "meh",
  variant = "zmk",
  auto_format_pattern = "*.keymap",
  layout = {
    "x x x x x x _ _ _ x x x x x x",
    "x x x x x x _ _ _ x x x x x x",
    "x x x x x x _ _ _ x x x x x x",
    "x x x x x x x _ x x x x x x x",
    "_ _ _ x x x x _ x x x x _ _ _",
  },
  comment_preview = {
    keymap_overrides = {
      ["K_VOL_UP"] = "vol+",
      ["K_VOL_DN"] = "vol-",
      ["KP_MULTIPLY"] = "*",
      ["KP_PLUS"] = "+",
    },
  },
})
-- { "xuhdev/vim-latex-live-preview" },
