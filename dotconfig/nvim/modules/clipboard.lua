-- Synchronizes nvim clipboard with system clipboard
-- only when nvim is going in/out of focus
-- Reduces clutter and may speed this up

-- If some other code writes to + register -
-- it shouldn't be overwritten on FocusLost
local should_set_system_clip = true
local force_disable = false

local orig_setreg = vim.fn.setreg
vim.fn.setreg = function(reg, ...)
  if reg == "+" then
    should_set_system_clip = false
  end

  orig_setreg(reg, ...)
end

local function set_system_clip()
  local clip = vim.fn.getreg('"')

  if not clip or clip == "" then
    return
  end

  orig_setreg("+", clip)
end

local function read_system_clip()
  local clip = vim.fn.getreg("+")

  if not clip or clip == "" then
    return
  end

  vim.fn.setreg('"', clip)
end

local group = augroup("deferred-clip")

autocmd({ "FocusGained", "VimEnter" }, {
  group = group,
  callback = function()
    if force_disable then
      return
    end
    -- if focus lost within 200, don't do anything
    should_set_system_clip = false
    -- When switching from one neovim instance immediately to another,
    -- the second one reads the old clipboard value, defer helps
    vim.defer_fn(function()
      should_set_system_clip = true
      read_system_clip()
    end, 200)
  end,
})

autocmd({ "FocusLost", "VimLeave" }, {
  group = group,
  callback = function()
    if force_disable then
      return
    end
    if should_set_system_clip == true then
      set_system_clip()
    end
  end,
})

local toggle_should_set_system_clip = function()
  force_disable = not force_disable
  if force_disable then
    vim.notify("Disabled automatic clipboard integration")
  else
    vim.notify("Enabled automatic clipboard integration")
  end
end

command("SysClipToggle", function()
  toggle_should_set_system_clip()
end)
