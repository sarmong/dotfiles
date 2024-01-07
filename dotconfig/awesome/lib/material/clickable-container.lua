local wibox = require("wibox")
local gears = require("gears")

local function build(widget, container_opts)
  local container = wibox.container.background(gears.table.join({
    widget = widget,
  }, container_opts))
  local old_cursor, old_wibox

  container:connect_signal("mouse::enter", function()
    container.bg = "#ffffff11"
    -- Hm, no idea how to get the wibox from this signal's arguments...
    local w = mouse.current_wibox
    if w then
      old_cursor, old_wibox = w.cursor, w
      w.cursor = "hand1"
    end
  end)

  container:connect_signal("mouse::leave", function()
    container.bg = "#ffffff00"
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end)

  container:connect_signal("button::press", function()
    container.bg = "#ffffff22"
  end)

  container:connect_signal("button::release", function()
    container.bg = "#ffffff11"
  end)

  return container
end

return build
