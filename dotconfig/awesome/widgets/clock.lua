local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local colors = require("theme.colors.gruvbox")

local format = "%H:%M %a %e %b"

local function Clock(s)
  local textclock = wibox.widget.textclock(
    '<span font="Roboto Mono 12">' .. format .. "</span>"
  )

  local month_calendar = awful.widget.calendar_popup.month({
    screen = s,
    start_sunday = false,
    week_numbers = true,
    style_weeknumber = {
      fg_color = colors.light4,
    },
  })
  month_calendar:attach(textclock)

  local clock_widget =
    wibox.container.margin(textclock, dpi(13), dpi(13), dpi(9), dpi(8))

  return clock_widget
end

return Clock
