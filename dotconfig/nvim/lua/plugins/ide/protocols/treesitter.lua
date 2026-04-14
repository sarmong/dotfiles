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
      or not vim.treesitter.get_parser()
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
  local contrib = req("plugins.ide.contrib")
  contrib.mason("tree-sitter-cli")

  Plugin("HiPhish/rainbow-delimiters.nvim")
  Plugin("windwp/nvim-ts-autotag")
  Plugin("nvim-treesitter/nvim-treesitter-textobjects")
  Plugin("nvim-treesitter/nvim-treesitter-context")
  Plugin("JoosepAlviste/nvim-ts-context-commentstring")

  req("nvim-treesitter-textobjects").setup({
    select = { lookahead = true },
    move = { set_jumps = true },
  })

  local to_select = lreq("nvim-treesitter-textobjects.select")
  local to_swap = lreq("nvim-treesitter-textobjects.swap")
  local to_move = lreq("nvim-treesitter-textobjects.move")

  map({ "x", "o" }, "af", function()
    to_select.select_textobject("@function.outer", "textobjects")
  end)
  map({ "x", "o" }, "if", function()
    to_select.select_textobject("@function.inner", "textobjects")
  end)

  map("n", "<leader>ts", function()
    to_swap.swap_next("@parameter.inner")
  end)
  map("n", "<leader>tS", function()
    to_swap.swap_previous("@parameter.outer")
  end)

  map({ "n", "x", "o" }, "]m", function()
    to_move.goto_next_start("@function.outer", "textobjects")
  end)
  map({ "n", "x", "o" }, "]M", function()
    to_move.goto_next_end("@function.outer", "textobjects")
  end)
  map({ "n", "x", "o" }, "[m", function()
    to_move.goto_previous_start("@function.outer", "textobjects")
  end)
  map({ "n", "x", "o" }, "[M", function()
    to_move.goto_previous_end("@function.outer", "textobjects")
  end)

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
