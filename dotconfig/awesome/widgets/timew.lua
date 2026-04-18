local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local HOME = os.getenv("HOME")

local w = wibox.widget({ widget = wibox.widget.textbox, font = "Roboto medium 9" })

awful.widget.watch(HOME .. "/.config/i3/bin/timew.sh", 1, function(widget, stdout)
  widget:set_text(stdout:gsub("%s+$", ""))
end, w)

return wibox.container.margin(w, dpi(5), dpi(5), dpi(9), dpi(8))
