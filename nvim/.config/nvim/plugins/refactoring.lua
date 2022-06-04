local refactoring = require("refactoring")

refactoring.setup({})

local fns = {
  -- Visual mode
  extract_fn = function()
    vim.cmd([[<Esc>]])
    refactoring.refactor("Extract Function")
    vim.cmd([[<CR>]])
  end,
  extract_fn_to_file = function()
    vim.cmd(
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]]
    )
  end,
  extract_var = function()
    vim.cmd(
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]]
    )
  end,

  -- Both visual and normal
  inline_var = function()
    vim.cmd(
      [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]]
    )
  end,

  -- Visual mode
  extract_block = function()
    vim.cmd([[<Cmd>lua require('refactoring').refactor('Extract Block')<CR>]])
  end,
  extract_block_to_file = function()
    vim.cmd(
      [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]]
    )
  end,

  print_debug = function()
    refactoring.debug.printf({ below = true })
  end,

  print_var = function()
    refactoring.debug.print_var({})
  end,

  debug_cleanup = function()
    refactoring.debug.cleanup({})
  end,
}

return fns
