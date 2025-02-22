local contrib = req("plugins.ide.contrib")

-- Ansible
contrib.mason({ "ansiblels", "ansible-lint" })
contrib.lsp("ansiblels")

-- YAML
contrib.mason({ "prettierd", "prettierd" })
contrib.formatters("yaml", { "prettierd", "prettier" })
contrib.ts_parsers("yaml")

-- Clang
contrib.mason("clangd")
contrib.lsp("clangd")
contrib.ts_parsers("c")

-- VimScript
contrib.mason("vimls")
contrib.lsp("vimls")
contrib.ts_parsers({ "vim", "vimdoc" })

-- JSON
contrib.mason({ "prettierd", "prettierd" })
contrib.formatters({ "json", "jsonc" }, { "prettierd", "prettier" })
contrib.ts_parsers({ "json", "json5", "jsonc" })

-- HTMX
contrib.mason("htmx")
contrib.lsp("htmx", function()
  return {
    filetypes = {
      "html",
      "templ",
      "javascriptreact",
      "typescriptreact",
      "astro",
    },
  }
end)

-- Other TS parser
contrib.ts_parsers({
  "awk",
  "comment",
  "csv",
  "dockerfile",
  "http",
  "java",
  "jq",
  "latex",
  "make",
  "org",
  "proto",
  "pug",
  "query",
  "rasi",
  "regex",
  "rust",
  "sql",
  "toml",
  "tsv",
})

-- Other prettier fts
contrib.formatters({ "graphql", "handlebars" }, { "prettierd", "prettier" })

Plugin("martinlroth/vim-devicetree")
Plugin("sarmong/lf-vim") -- TODO: remove when in stable - https://github.com/neovim/neovim/pull/30801
Plugin("sarmong/newsboat.vim")
Plugin("kovetskiy/sxhkd-vim")
Plugin("sarmong/conky-syntax.vim")
Plugin("elkowar/yuck.vim")
Plugin("fladson/vim-kitty")
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
