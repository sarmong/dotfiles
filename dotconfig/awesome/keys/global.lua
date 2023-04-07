local hotkeys_popup = require("awful.hotkeys_popup")
local revelation = require("lib.revelation")

local gen_keys = require("keys.gen-keys")
local super = require("keys.mod").super
local ctrl = require("keys.mod").ctrl
local shift = require("keys.mod").shift

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
    description = "Quit awesome",
    modifiers = { super, shift, ctrl },
    key = "q",
    on_press = awesome.quit,
    group = "awesome",
  },
}

return gen_keys(globalKeys)
