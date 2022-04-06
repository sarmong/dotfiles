local filesystem = require("gears.filesystem")

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require("beautiful").xresources.apply_dpi
local get_dpi = require("beautiful").xresources.get_dpi
local rofi_command = "env /usr/bin/rofi -dpi "
  .. get_dpi()
  .. " -width "
  .. with_dpi(400)
  .. " -show drun -theme "
  .. filesystem.get_configuration_dir()
  .. "/configuration/rofi.rasi -run-command \"/bin/bash -c -i 'shopt -s expand_aliases; {cmd}'\""

return {
  -- List of apps to start by default on some actions
  default = {
    terminal = "alacritty",
    rofi = rofi_command,
    lock = "i3lock-fancy",
    quake = "kitty",
    screenshot = "flameshot gui",
    browser = "brave-browser",
    social = "discord",
    game = rofi_command,
    files = "nautilus",
    music = rofi_command,
    editor = "alacritty -e nvim",
    notes = "alacritty --working-directory ~/docs/nextcloud/Vault -e nvim",
    config = "alacritty --working-directory ~/docs/dotfiles -e nvim",
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    -- @TODO find out what the hell is this
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)", -- credential manager

    -- Essentials
    "nm-applet --indicator", -- network tray
    "pnmixer", -- audiocontrol tray
    "xfce4-power-manager", -- power manager tray
    "udiskie", -- mounts drives automatically
    "picom",

    -- Applications
    "nextcloud",
    "touchegg",
    "copyq",
    "redshift",

    -- Configuration
    "feh --bg-fill $HOME/Pictures/wp.png &",
    "~/bin/setup/keyboard/init.sh",
    "~/bin/setup/screenlayout/monitor-on-top.sh",
    -- @TODO turn on bluetooth depending on whether keyboard is connected
    -- "bluetooth off",
  },
}
