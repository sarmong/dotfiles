return {
  { "martinlroth/vim-devicetree", event = "VeryLazy" },
  { "sarmong/lf-vim", event = "VeryLazy" },
  { "sarmong/newsboat.vim", event = "VeryLazy" },
  { "kovetskiy/sxhkd-vim", event = "VeryLazy" },
  { "sarmong/conky-syntax.vim", event = "VeryLazy" },
  { "elkowar/yuck.vim", event = "VeryLazy" },
  { "fladson/vim-kitty", event = "VeryLazy" },
  {
    "codethread/qmk.nvim",
    event = "VeryLazy",
    config = function()
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
    end,
  },
  -- { "xuhdev/vim-latex-live-preview" },
}
