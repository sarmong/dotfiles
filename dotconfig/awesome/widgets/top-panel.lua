local awful = require("awful")
local wibox = require("wibox")
local Task_list = require("widgets.task-list")
local Tag_list = require("widgets.tag-list")
local Layout_box = require("widgets.layout-box")
local Clock_widget = require("widgets.clock")
local mat_icon_button = require("lib.material.icon-button")
local mat_icon = require("lib.material.icon")
local dpi = require("beautiful").xresources.apply_dpi
local icons = require("theme.icons")

local systray =
  wibox.container.margin(wibox.widget.systray(), dpi(6), dpi(6), dpi(6), dpi(6))

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(awful.button({}, 1, function()
  awful.spawn(awful.screen.focused().selected_tag.get_default_app(), {
    tag = mouse.screen.selected_tag,
    placement = awful.placement.bottom_right,
  })
end))

local top_panel = function(s)
  return awful.wibar({
    position = "top",
    screen = s,
    height = dpi(32),
    widget = {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        Tag_list(s),
        Task_list(s),
        add_button,
      },
      nil,
      {
        layout = wibox.layout.fixed.horizontal,
        awful.widget.keyboardlayout(),
        systray,
        Layout_box(s),
        Clock_widget(s),
      },
    },
  })
end

awful.screen.connect_for_each_screen(function(s)
  s.top_panel = top_panel(s)
end)
