-- Synchronizes nvim clipboard with system clipboard
-- only when nvim is going in/out of focus
-- Reduces clutter and may speed this up
local function set_system_clip()
  local clip = vim.fn.getreg('"')

  vim.fn.setreg("+", clip)
end

local function read_system_clip()
  local clip = vim.fn.getreg("+")

  vim.fn.setreg('"', clip)
end

autocmd("FocusGained", {
  callback = function()
    read_system_clip()
  end,
})

autocmd("FocusLost", {
  callback = function()
    set_system_clip()
  end,
})
