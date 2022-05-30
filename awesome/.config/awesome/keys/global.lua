local awful = require("awful")
require("awful.autofocus")
local hotkeys_popup = require("awful.hotkeys_popup")
local revelation = require("lib.revelation")

local super = require("keys.mod").super

local globalKeys = {
  awful.key({
    modifiers = { super },
    key = "F1",
    on_press = hotkeys_popup.show_help,
    description = "Show help",
    group = "awesome",
  }),

  awful.key({
    modifiers = { super },
    key = "r",
    on_press = revelation,
    description = "open revelation",
  }),
  awful.key({
    modifiers = { super, "Control" },
    key = "r",
    on_press = _G.awesome.restart,
    description = "reload awesome",
    group = "awesome",
  }),
  awful.key({
    modifiers = { super, "Shift", "Control" },
    key = "q",
    on_press = _G.awesome.quit,
    description = "quit awesome",
    group = "awesome",
  }),

  -- Change keyboard layout
  awful.key({
    modifiers = { super },
    key = "/",
    on_press = function()
      awful.spawn.with_shell("$XDG_BIN_DIR/setup/keyboard/switch-layout.sh")
    end,
    description = "Change keyboard layout",
    group = "hotkeys",
  }),
  -- Emoji Picker
  awful.key({
    modifiers = { super },
    key = "a",
    on_press = function()
      awful.util.spawn_with_shell("ibus emoji")
    end,
    description = "Open the ibus emoji picker to copy an emoji to your clipboard",
    group = "hotkeys",
  }),
}

return globalKeys
