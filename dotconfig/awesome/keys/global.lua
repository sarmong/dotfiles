local gears = require("gears")
local naughty = require("naughty")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local revelation = require("lib.revelation")

local gen_keys = require("keys.gen-keys")
local super = require("keys.mod").super
local ctrl = require("keys.mod").ctrl
local shift = require("keys.mod").shift

local replay_last_notif = require("modules.notifications")

local globalKeys = {
  {
    description = "Show help",
    modifiers = { super },
    key = "F1",
    on_press = hotkeys_popup.show_help,
    group = "awesome",
  },

  {
    description = "Reveal all windows",
    modifiers = { super, ctrl },
    key = "r",
    on_press = revelation,
  },
  {
    description = "Reload awesome",
    modifiers = { super, shift, ctrl },
    key = "r",
    on_press = awesome.restart,
    group = "awesome",
  },
  {
    description = "Remove notifications",
    modifiers = { super },
    key = ".",
    on_press = function()
      naughty.destroy_all_notifications()
    end,
    group = "notifications",
  },

  {
    description = "Close all notifications",
    modifiers = { super },
    key = ".",
    on_press = function()
      awful.spawn("dunstctl close-all")
    end,
    group = "notifications",
  },
  {
    description = "Previous notification",
    modifiers = { super },
    key = ",",
    on_press = function()
      awful.spawn("dunstctl history-pop")
    end,
    group = "notifications",
  },
  {
    description = "Notification action",
    modifiers = { super },
    key = "/",
    on_press = function()
      awful.spawn("dunstctl action")
    end,
    group = "notifications",
  },
  {
    description = "Notification history",
    modifiers = { super },
    key = "n",
    on_press = function()
      awful.spawn("nothis")
    end,
    group = "notifications",
  },
}

return gen_keys(globalKeys)
