local fns = {
  next = function()
    vim.cmd("BufferNext")
  end,

  prev = function()
    vim.cmd("BufferPrevious")
  end,

  move_next = function()
    vim.cmd("BufferMoveNext")
  end,

  move_prev = function()
    vim.cmd("BufferMovePrevious")
  end,

  pin = function()
    vim.cmd("BufferPin")
  end,

  close = function()
    vim.cmd("BufferClose")
  end,

  go_to = function(n)
    vim.cmd("BufferGoto " .. n)
  end,

  pick = function()
    vim.cmd("BufferPick")
  end,

  close_all_but_current = function()
    vim.cmd("BufferCloseAllButCurrent")
  end,

  close_all_but_pinned = function()
    vim.cmd("BufferCloseAllButPinned")
  end,

  close_all_to_the_left = function()
    vim.cmd("BufferCloseBuffersLeft")
  end,

  close_all_to_the_right = function()
    vim.cmd("BufferCloseBuffersRight")
  end,

  order_by_directory = function()
    vim.cmd("BufferOrderByDirectory")
  end,
}

vim.g.bufferline = {
  icons = "both",
  exclude_ft = { "qf" },
}

return fns
