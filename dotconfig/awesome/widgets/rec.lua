local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local clickable_container = require("lib.material.clickable-container")

local content = {
  idle = "",
  rec = "",
}

rec_widget = wibox.widget({
  markup = "<span color='#ffffff'>" .. content.idle .. "</span>",
  widget = wibox.widget.textbox,
  font = "Roboto medium 16",
})

local rec_container =
  clickable_container(wibox.container.margin(rec_widget, dpi(10), dpi(10)))

rec_container.visible = false
rec_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
  awful.spawn("pkill -f record_screen.sh")
end)))

local function hide_widget_with_timeout()
  gears.timer({
    timeout = 60,
    call_now = false,
    autostart = true,
    single_shot = true,
    callback = function()
      rec_container.visible = false
    end,
  })
end

rec_widget:connect_signal("start_rec", function()
  rec_widget:set_markup("<span color='#ff0000'>" .. content.rec .. "</span>")
  rec_widget:set_font("Roboto medium 10")

  rec_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
    awful.spawn.with_shell("kill -INT $(cat /tmp/rec_pid)")
  end)))

  rec_container.visible = true
end)

rec_widget:connect_signal("stop_rec", function()
  rec_widget:set_markup("<span color='#ffffff'>" .. content.idle .. "</span>")
  rec_widget:set_font("Roboto medium 16")

  rec_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
    awful.spawn.with_shell("rec")
  end)))

  hide_widget_with_timeout()
end)

return rec_container
