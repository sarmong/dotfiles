local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local clickable_container = require("lib.material.clickable-container")

-- Function to check if the process is running
local function is_process_running(process_name)
  local cmd = "pgrep  " .. process_name
  local f = io.popen(cmd)
  local result = f:read("*a")
  f:close()
  return result ~= ""
end

-- Create a textbox widget for the status
-- status_widget = awful.widget.watch(
--   'sh -c "pgrep rec > /dev/null && echo Recording || echo Idle"',
--   5, -- Update interval in seconds
--   function(widget, stdout)
--     local status = stdout:gsub("\n", "")
--     widget:set_text(" " .. status .. " ")
--   end
-- )
--
local status = "idle"

local content = {
  idle = "",
  rec = "",
}

status_widget = wibox.widget({
  markup = "<span color='#ffffff'>" .. content.idle .. "</span>",
  widget = wibox.widget.textbox,
  font = "Roboto medium 16",
})

status_widget:connect_signal("start_rec", function()
  status_widget:set_markup("<span color='#ff0000'>" .. content.rec .. "</span>")
  status_widget:set_font("Roboto medium 10")
end)

status_widget:connect_signal("stop_rec", function()
  status_widget:set_markup(
    "<span color='#ffffff'>" .. content.idle .. "</span>"
  )
  status_widget:set_font("Roboto medium 16")
end)

-- Optionally, you can customize the appearance of the status_widget
-- status_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
--   awful.spawn("pkill -f record_screen.sh")
-- end)))
-- status_widget:set_font("Monospace 10")
-- status_widget:set_fg("#ffffff")
-- status_widget:set_bg("#333333")

return clickable_container(
  wibox.container.margin(status_widget, dpi(10), dpi(10))
)
