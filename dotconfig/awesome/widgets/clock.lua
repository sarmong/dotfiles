local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local colors = require("theme.colors.current")

local format = "%H:%M %a %e %b"

local function Clock(s)
  local textclock = wibox.widget.textclock(
    '<span font="Roboto Mono 12">' .. format .. "</span>"
  )

  local month_calendar = awful.widget.calendar_popup.month({
    screen = s,
    position = "tr",
    start_sunday = false,
    week_numbers = true,
    style_weeknumber = {
      fg_color = colors.light4,
    },
  })

  local orig_embed = month_calendar.widget:get_fn_embed()
  month_calendar.widget:set_fn_embed(function(widget, flag, date)
    local w = orig_embed(widget, flag, date)
    if flag == "normal" or flag == "focus" then
      local orig_bg = w.bg
      w:connect_signal("mouse::enter", function()
        w.bg = colors.dark2
        mouse.current_wibox.cursor = "hand2"
      end)
      w:connect_signal("mouse::leave", function()
        w.bg = orig_bg
        mouse.current_wibox.cursor = "left_ptr"
      end)
      w:buttons(awful.util.table.join(awful.button({}, 1, function() end)))
    end
    return w
  end)

  month_calendar:attach(textclock)
  s.calendar = month_calendar

  local clock_widget =
    wibox.container.margin(textclock, dpi(13), dpi(13), dpi(9), dpi(8))

  return clock_widget
end

return Clock
