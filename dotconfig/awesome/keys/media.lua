local awful = require("awful")

local gen_keys = require("keys.gen-keys")

local group_name = "Media keys"

local keys = {

  -- Brightness
  -- {
  --   description = "Increase brightness +10%",
  --   key = "XF86MonBrightnessUp",
  --   on_press = function()
  --     awful.spawn("brightnessctl set +10%")
  --   end,
  -- },
  -- {
  --   description = "Decrease brightness -10%",
  --   key = "XF86MonBrightnessDown",
  --   on_press = function()
  --     awful.spawn("brightnessctl set 10%-")
  --   end,
  -- },

  -- Volume control
  -- {
  --   description = "Volume up",
  --   key = "XF86AudioRaiseVolume",
  --   on_press = function()
  --     awful.spawn("pulsemixer --change-volume +5")
  --   end,
  -- },
  -- {
  --   description = "Volume down",
  --   key = "XF86AudioLowerVolume",
  --   on_press = function()
  --     awful.spawn("pulsemixer --change-volume -5")
  --   end,
  -- },
  -- {
  --   description = "Toggle mute",
  --   key = "XF86AudioMute",
  --   on_press = function()
  --     awful.spawn("pulsemixer --toggle-mute")
  --   end,
  -- },
  -- {
  --   description = "Play/Pause audio",
  --   key = "XF86AudioPlay",
  --   on_press = function()
  --     awful.spawn("playerctl play-pause")
  --   end,
  -- },
  -- {
  --   description = "Previous track",
  --   key = "XF86AudioPrev",
  --   on_press = function()
  --     awful.spawn("playerctl previous")
  --   end,
  -- },
  -- {
  --   description = "Next track",
  --   key = "XF86AudioNext",
  --   on_press = function()
  --     awful.spawn("playerctl next")
  --   end,
  -- },
  {
    description = "1 - Previous track",
    key = "KP_End",
    on_press = function()
      awful.spawn("playerctl previous")
    end,
  },
  {
    description = "3 - Next track",
    key = "KP_Next",
    on_press = function()
      awful.spawn("playerctl next")
    end,
  },
  {
    description = "2 - Play/Pause spotify",
    key = "KP_Down",
    on_press = function()
      awful.spawn("playerctl --player=spotify play-pause")
    end,
  },
  {
    description = "5 - Play/Pause firefox",
    key = "KP_Begin",
    on_press = function()
      awful.spawn("playerctl --player=firefox play-pause")
    end,
  },
  {
    description = "8 - Play/Pause mpv",
    key = "KP_Up",
    on_press = function()
      awful.spawn("playerctl --player=mpv play-pause")
    end,
  },
}

return gen_keys(keys, { modifiers = {}, group = group_name })
