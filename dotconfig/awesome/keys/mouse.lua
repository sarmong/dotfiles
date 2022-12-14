local awful = require("awful")

local super = require("keys.mod").super

local mousebindings = awful.util.table.join(
  awful.button({}, 1, function(c)
    _G.client.focus = c
    c:raise()
  end),
  awful.button({ super }, 1, awful.mouse.client.move),
  awful.button({ super, "Shift" }, 1, awful.mouse.client.resize),
  awful.button({ super }, 3, awful.mouse.client.resize),
  awful.button({ super }, 4, function()
    awful.layout.inc(1)
  end),
  awful.button({ super }, 5, function()
    awful.layout.inc(-1)
  end)
)

return mousebindings
