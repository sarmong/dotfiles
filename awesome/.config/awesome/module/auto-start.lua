-- MODULE AUTO-START
-- Run all the apps listed in configuration/apps.lua as run_on_start_up only once when awesome start

local awful = require("awful")
local apps = require("configuration.apps")

local function run_once(cmd)
  local base_command = cmd
  -- trims all arguments from a command to find it in processes
  local firstspace = cmd:find(" ")
  if firstspace then
    base_command = cmd:sub(0, firstspace - 1)
  end

  awful.spawn.with_shell(
    string.format("pgrep -u $USER -x %s > /dev/null || (%s)", base_command, cmd)
  )
end

for _, app in ipairs(apps.run_on_start_up) do
  run_once(app)
end
