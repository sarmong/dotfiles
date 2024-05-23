-- Synchronizes nvim clipboard with system clipboard
-- only when nvim is going in/out of focus
-- Reduces clutter and may speed this up

-- If some other code writes to + register -
-- it shouldn't be overwritten on FocusLost
local should_set_system_clip = true
local orig_setreg = vim.fn.setreg
vim.fn.setreg = function(reg, ...)
  if reg == "+" then
    should_set_system_clip = false
  end

  orig_setreg(reg, ...)
end

local function set_system_clip()
  local clip = vim.fn.getreg('"')

  orig_setreg("+", clip)
end

local function read_system_clip()
  local clip = vim.fn.getreg("+")

  vim.fn.setreg('"', clip)
end

autocmd("FocusGained", {
  group = "deferred-clip",
  callback = function()
    should_set_system_clip = true
    -- When switching from one neovim instance immediately to another,
    -- the second one reads the old clipboard value, defer helps
    vim.defer_fn(read_system_clip, 50)
  end,
})

autocmd("FocusLost", {
  group = "deferred-clip",
  callback = function()
    if should_set_system_clip == true then
      set_system_clip()
    end
  end,
})
