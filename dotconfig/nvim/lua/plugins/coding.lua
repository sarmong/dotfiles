local refactoring_fns = {
  -- Visual mode
  extract_fn = function()
    req("refactoring").refactor("Extract Function")
  end,
  extract_fn_to_file = function()
    req("refactoring").refactor("Extract Function To File")
  end,
  extract_var = function()
    req("refactoring").refactor("Extract Variable")
  end,

  -- Both visual and normal
  inline_var = function()
    req("refactoring").refactor("Inline Variable")
  end,

  -- Normal mode
  extract_block = function()
    req("refactoring").refactor("Extract Block")
  end,
  extract_block_to_file = function()
    req("refactoring").refactor("Extract Block To File")
  end,

  print_debug = function()
    req("refactoring").debug.printf({ below = true })
  end,

  print_var = function()
    req("refactoring").debug.print_var({ normal = true })
  end,

  debug_cleanup = function()
    req("refactoring").debug.cleanup({})
  end,
}

-- disable all mappings expect for C-n
-- This way, it will not interfere with C-up and C-down for window resizing
vim.g.VM_default_mappings = 0

Plugin("metakirby5/codi.vim")

Plugin("danymat/neogen")
req("neogen").setup({})

Plugin("bkad/CamelCaseMotion")

Plugin("azabiong/vim-highlighter")
Plugin("tpope/vim-surround")

Plugin("windwp/nvim-autopairs")
local npairs = req("nvim-autopairs")
local Rule = req("nvim-autopairs.rule")

npairs.setup({
  map_c_w = true, -- map <c-w> to delete a pair if possible
})

npairs.add_rule()
npairs.add_rules({
  Rule("{/*", "*/", { "javascript", "typescript", "typescriptreact" }),
})

Plugin("ThePrimeagen/refactoring.nvim")
req("refactoring").setup({
  print_var_statements = {
    javascript = {
      "console.log('%s ', %s);",
    },
    typescript = {
      "console.log('%s ', %s);",
    },
  },
})

mapl({
  r = {
    i = { refactoring_fns.inline_var, "inline variable" },
    b = {
      name = "block",
      e = { refactoring_fns.extract_block, "extract block" },
      f = {
        refactoring_fns.extract_block_to_file,
        "extract block to a file",
      },
    },
    p = { refactoring_fns.print_debug, "print debug" },
    v = { refactoring_fns.print_var, "print variable" },
    c = { refactoring_fns.debug_cleanup, "debug cleanup" },
  },
})

mapl("v", {
  r = {
    e = { refactoring_fns.extract_fn, "extract function" },
    f = {
      refactoring_fns.extract_fn_to_file,
      "extract function to a file",
    },
    v = { refactoring_fns.extract_var, "extract variable" },
    i = { refactoring_fns.inline_var, "inline variable" },
  },
})

Plugin({
  "numToStr/Comment.nvim",
  depends = { "JoosepAlviste/nvim-ts-context-commentstring" },
})
-- taken from https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
req("Comment").setup({
  pre_hook = req("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

-- for some reason in vim _ and / are swapped
map("n", "<C-_>", function()
  req("Comment.api").toggle.linewise()
end)
map("x", "<C-_>", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  req("Comment.api").toggle.linewise(vim.fn.visualmode())
end)

Plugin("NvChad/nvim-colorizer.lua")
req("colorizer").setup({
  filetypes = {
    "css",
    "scss",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
  },
  user_default_options = {
    RGB = true, -- #fff hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    names = true, -- "Name" codes like Blue
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    mode = "background", --  foreground, background,  virtualtext
  },
})

mapl({
  a = {
    c = { cmd.bind("ColorizerToggle"), "colorizer" },
  },
})

Plugin("nvim-pack/nvim-spectre")
local spectre = req("spectre")

spectre.setup({})

mapl({
  s = {
    r = {
      name = "replace",
      s = { spectre.open, "search and replace" },
      w = {
        function()
          spectre.open_visual({ select_word = true })
        end,
        "search and replace word",
      },
    },
  },
})
