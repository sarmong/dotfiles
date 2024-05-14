Plugin("martinlroth/vim-devicetree")
Plugin("sarmong/lf-vim")
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
