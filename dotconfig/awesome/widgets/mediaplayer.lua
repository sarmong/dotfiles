local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local w =
  wibox.widget({ widget = wibox.widget.textbox, font = "Roboto medium 9" })
local container = wibox.container.margin(w, dpi(5), dpi(5), dpi(9), dpi(8))
container.visible = false

local status_icons = { Playing = "▶ ", Paused = "⏸ " }

awful.widget.watch(
  "playerctl metadata --format '{{ status }}\t{{ artist }} - {{ title }}' 2>/dev/null",
  5,
  function(widget, stdout)
    local line = stdout:gsub("%s+$", "")
    local status, title = line:match("^(%S+)\t(.+)$")
    if not title then
      container.visible = false
      return
    end
    if #title > 30 then
      title = title:sub(1, 30) .. "..."
    end
    widget:set_text((status_icons[status] or "") .. title)
    container.visible = true
  end,
  w
)
container:buttons(awful.util.table.join(
  awful.button({}, 1, function()
    awful.spawn("playerctl play-pause")
  end),
  awful.button({}, 2, function()
    awful.spawn("playerctl previous")
  end),
  awful.button({}, 3, function()
    awful.spawn("playerctl next")
  end)
))
return container
