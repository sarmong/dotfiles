local awful = require("awful")
require("awful.autofocus")
local modkey = require("configuration.keys.mod").modKey

local clientKeys = awful.util.table.join(
  awful.key({
    modifiers = { modkey },
    key = "m",
    on_press = function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    description = "toggle maximized",
    group = "client",
  }),
  awful.key({
    modifiers = { modkey },
    key = "f",
    description = "toggle float",
    group = "client",
    on_press = function(c)
      c.floating = not c.floating
      -- @TODO make window smaller
      awful.placement.centered(c)
      c:raise()
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "f",
    description = "toggle fullscreen",
    group = "client",
    on_press = function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "s",
    description = "toggle sticky",
    group = "client",
    on_press = function(c)
      c.sticky = not c.sticky
      c.ontop = not c.ontop
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "q",
    description = "close client with confirmation",
    group = "client",
    on_press = function(c)
      awful.spawn.with_line_callback(
        "bash -c 'prompt-yn \"Kill " .. c.name .. "\"? '",
        {
          stdout = function(stdout)
            if stdout == "Yes" then
              c:kill()
            end
          end,
        }
      )
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "q",
    description = "close client without confirmation",
    group = "client",
    on_press = function(c)
      c:kill()
    end,
  })
)

awful.keyboard.append_client_keybindings(clientKeys)
