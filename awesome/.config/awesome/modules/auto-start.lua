local awful = require("awful")

local apps = {
  -- Essentials
  "lxpolkit",
  "nm-applet --indicator", -- network tray
  "volctl", -- audiocontrol tray
  "xfce4-power-manager", -- power manager tray
  "udiskie --smart-tray", -- mounts drives automatically
  "picom",

  -- Applications
  "nextcloud",
  "touchegg",
  "CM_SELECTIONS='clipboard' clipmenud",
  "redshift",
  "safeeyes",

  -- Configuration
  "feh --bg-fill $XDG_PICTURES_DIR/wallpaper.png &",
  "$XDG_BIN_DIR/setup/keyboard/init.sh",
  "$XDG_BIN_DIR/setup/screenlayout/init.sh",
  "unclutter",
  -- @TODO turn on bluetooth depending on whether keyboard is connected
  -- "bluetooth off",
}

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

for _, app in ipairs(apps) do
  run_once(app)
end