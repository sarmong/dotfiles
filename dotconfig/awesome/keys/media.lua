local awful = require("awful")

local group_name = "Media keys"

local keys = {

  -- Brightness
  awful.key({
    modifiers = {},
    key = "XF86MonBrightnessUp",
    on_press = function()
      awful.spawn("brightnessctl set +10%")
    end,
    description = "Increase brightness +10%",
    group = group_name,
  }),
  awful.key({
    modifiers = {},
    key = "XF86MonBrightnessDown",
    on_press = function()
      awful.spawn("brightnessctl set 10%-")
    end,
    description = "Decrease brightness -10%",
    group = group_name,
    group = "hotkeys",
  }),

  -- Volume control
  awful.key({
    description = "Volume up",
    modifiers = {},
    key = "XF86AudioRaiseVolume",
    on_press = function()
      awful.spawn("pulsemixer --change-volume +5")
    end,
    group = group_name,
  }),
  awful.key({
    description = "Volume down",
    modifiers = {},
    key = "XF86AudioLowerVolume",
    on_press = function()
      awful.spawn("pulsemixer --change-volume -5")
    end,
    group = group_name,
  }),
  awful.key({
    description = "Toggle mute",
    modifiers = {},
    key = "XF86AudioMute",
    on_press = function()
      awful.spawn("pulsemixer --toggle-mute")
    end,
    group = group_name,
  }),
  awful.key({
    description = "Play/Pause audio",
    modifiers = {},
    key = "XF86AudioPlay",
    on_press = function()
      awful.spawn("playerctl play-pause")
    end,
    group = group_name,
  }),
  awful.key({
    description = "1 - Previous track",
    modifiers = {},
    key = "KP_End",
    on_press = function()
      awful.spawn("playerctl previous")
    end,
    group = group_name,
  }),
  awful.key({
    description = "3 - Next track",
    modifiers = {},
    key = "KP_Next",
    on_press = function()
      awful.spawn("playerctl next")
    end,
    group = group_name,
  }),
  awful.key({
    description = "2 - Play/Pause spotify",
    modifiers = {},
    key = "KP_Down",
    on_press = function()
      awful.spawn("playerctl --player=spotify play-pause")
    end,
    group = group_name,
  }),
  awful.key({
    description = "5 - Play/Pause firefox",
    modifiers = {},
    key = "KP_Begin",
    on_press = function()
      awful.spawn("playerctl --player=firefox play-pause")
    end,
    group = group_name,
  }),
  awful.key({
    description = "8 - Play/Pause mpv",
    modifiers = {},
    key = "KP_Up",
    on_press = function()
      awful.spawn("playerctl --player=mpv play-pause")
    end,
    group = group_name,
  }),
}

return keys
