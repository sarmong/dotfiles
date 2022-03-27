local awful = require("awful")
require("awful.autofocus")
local modkey = require("configuration.keys.mod").modKey
local altkey = require("configuration.keys.mod").altKey

local clientKeys = awful.util.table.join(
  awful.key({ modkey }, "f", function(c)
    c.floating = not c.floating
    awful.placement.centered(c)
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "f", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" })
)

return clientKeys
