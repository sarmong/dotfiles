-- Synchronizes nvim clipboard with system clipboard
-- only when nvim is going in/out of focus
-- Reduces clutter and may speed this up

local should_set_system_clip = true
local snapshot_on_focus = nil -- value of " at FocusGained, to detect yanks during grace period
local last_synced_clip = nil -- last value we wrote to +, to detect external clipboard changes
local force_disable = false

local function set_system_clip()
  local clip = vim.fn.getreg('"')

  if not clip or clip == "" then
    return
  end

  vim.fn.setreg("+", clip)
  last_synced_clip = clip
end

local function read_system_clip()
  local clip = vim.fn.getreg("+")

  if not clip or clip == "" then
    return
  end

  -- Only update " if + actually changed externally; avoids clobbering recent yanks
  if clip == last_synced_clip then
    return
  end

  vim.fn.setreg('"', clip)
  last_synced_clip = clip
end

local group = augroup("deferred-clip")

autocmd({ "FocusGained", "VimEnter" }, {
  group = group,
  callback = function()
    if force_disable then
      return
    end
    -- When switching from one neovim instance immediately to another,
    -- the second one reads the old clipboard value, defer helps
    snapshot_on_focus = vim.fn.getreg('"')
    should_set_system_clip = false

    vim.defer_fn(function()
      should_set_system_clip = true
      read_system_clip()
    end, 100)
  end,
})

autocmd({ "FocusLost", "VimLeave" }, {
  group = group,
  callback = function()
    if force_disable then
      return
    end
    local reg_changed = vim.fn.getreg('"') ~= snapshot_on_focus
    -- If + was changed externally and the user didn't yank, respect the external change
    local plus_changed_externally = last_synced_clip ~= nil
      and vim.fn.getreg("+") ~= last_synced_clip
    if plus_changed_externally and not reg_changed then
      return
    end
    if should_set_system_clip and reg_changed then
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
