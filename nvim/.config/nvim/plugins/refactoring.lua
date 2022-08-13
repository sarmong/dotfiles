local refactoring = require("refactoring")

refactoring.setup({})

local fns = {
  -- Visual mode
  extract_fn = function()
    refactoring.refactor("Extract Function")
  end,
  extract_fn_to_file = function()
    refactoring.refactor("Extract Function To File")
  end,
  extract_var = function()
    refactoring.refactor("Extract Variable")
  end,

  -- Both visual and normal
  inline_var = function()
    refactoring.refactor("Inline Variable")
  end,

  -- Normal mode
  extract_block = function()
    refactoring.refactor("Extract Block")
  end,
  extract_block_to_file = function()
    refactoring.refactor("Extract Block To File")
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
