local awful = require("awful")
require("awful.autofocus")
local modkey = require("configuration.keys.mod").modKey
local altkey = require("configuration.keys.mod").altKey

local clientKeys = awful.util.table.join(
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "toggle maximized", group = "client" }),
  awful.key({ modkey }, "f", function(c)
    c.floating = not c.floating
    -- @TODO make window smaller
    awful.placement.centered(c)
    c:raise()
  end, { description = "toggle float", group = "client" }),
  awful.key({ modkey, "Shift" }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "s", function(c)
    c.sticky = not c.sticky
    c.ontop = not c.ontop
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey }, "q", function(c)
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
  end, { description = "close", group = "client" })
)

return clientKeys
