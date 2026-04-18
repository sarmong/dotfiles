local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local w = wibox.widget({ widget = wibox.widget.textbox })

awful.widget.watch("luna.sh bar", 3600, function(widget, stdout)
  widget:set_text(stdout:gsub("%s+$", ""))
end, w)

return wibox.container.margin(w, dpi(5), dpi(5), dpi(9), dpi(8))
