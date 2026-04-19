local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function make_button(symbol, get_hover_color, on_click)
  local btn = wibox.widget({
    {
      markup = symbol,
      align = "center",
      valign = "center",
      font = "Roboto medium 11",
      widget = wibox.widget.textbox,
    },
    forced_width = dpi(28),
    bg = "transparent",
    widget = wibox.container.background,
  })
  btn:connect_signal("mouse::enter", function(w)
    w.bg = get_hover_color()
  end)
  btn:connect_signal("mouse::leave", function(w)
    w.bg = "transparent"
  end)
  btn:buttons({ awful.button({}, 1, on_click) })
  return btn
end

local function update_colors()
  for _, c in ipairs(client.get()) do
    if c.has_titlebar then
      local focused = client.focus == c
      awful.titlebar(c):set_bg(
        focused and beautiful.titlebar_button_hover_bg
          or beautiful.titlebar_bg_normal
      )
      awful.titlebar(c):set_fg(
        focused and beautiful.titlebar_fg_focus or beautiful.titlebar_fg_normal
      )
    end
  end
end

client.connect_signal("request::titlebars", function(c)
  c.has_titlebar = true
  local buttons = {
    awful.button({}, 1, function()
      c:activate({ context = "titlebar", action = "mouse_move" })
    end),
    awful.button({}, 3, function()
      c:activate({ context = "titlebar", action = "mouse_resize" })
    end),
  }

  awful.titlebar(c, { size = dpi(24) }).widget = {
    {
      {
        awful.titlebar.widget.iconwidget(c),
        margins = dpi(3),
        widget = wibox.container.margin,
      },
      {
        halign = "left",
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    {
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    {
      make_button("─", function()
        return beautiful.titlebar_button_hover_bg
      end, function()
        c.minimized = true
      end),
      make_button("▢", function()
        return beautiful.titlebar_button_hover_bg
      end, function()
        c.maximized = not c.maximized
      end),
      make_button("✕", function()
        return beautiful.titlebar_close_hover_bg
      end, function()
        c:kill()
      end),
      layout = wibox.layout.fixed.horizontal,
    },
    layout = wibox.layout.align.horizontal,
  }
end)

return { update_colors = update_colors }
