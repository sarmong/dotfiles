if _G.lean_mode then
  return
end

Plugin({
  "nvim-treesitter/nvim-treesitter",
  hooks = {
    post_checkout = cmd.bind("TSUpdate"),
  },
  checkout = "main",
})

req("nvim-treesitter").setup({})

req("nvim-treesitter").install(req("plugins.ide.contrib").state.ts_parsers)

autocmd("FileType", {
  pattern = "*",
  callback = function()
    if
      vim.api.nvim_buf_line_count(0) > 4000
      or vim.fn.getline(1):len() > 500
      or not vim.treesitter.get_parser(nil, nil, { error = false })
    then
      return
    end

    vim.treesitter.start()

    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

req("mini.deps").later(function()
  local opts = {
    -- TODO: replace setup
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
  }

  Plugin("HiPhish/rainbow-delimiters.nvim")
  Plugin("windwp/nvim-ts-autotag")
  -- Plugin("nvim-treesitter/nvim-treesitter-textobjects") -- TODO: setup
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

  req("modules.highlight-definitions").enable()
  req("modules.highlight-scope").enable()

  ---@diagnostic disable-next-line: missing-fields
  req("nvim-ts-autotag").setup({
    opts = {
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    },
  })

  -- Skip backwards compatibility routines and speed up loading
  vim.g.skip_ts_context_commentstring_module = true

  -- @TODO this plugins integrades with commentary by default.
  -- And only with gc. That's why it does'nt work with custom mappings
  req("ts_context_commentstring").setup({
    enable = true,
    enable_autocmd = false,
    config = { javascriptreact = { style_element = "{/*%s*/}" } },
  })
end)
