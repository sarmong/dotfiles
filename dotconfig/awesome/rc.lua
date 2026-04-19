package.loaded["naughty.dbus"] = {}

local awful = require("awful")
local conf_dir = awful.util.getdir("config")
package.path = package.path
  .. ";"
  .. conf_dir
  .. "/lib/?.lua;"
  .. conf_dir
  .. "/lib/?/init.lua"

require("modules.move-windows").connect()
require("theme")

require("utils")

local top_panel = require("widgets.top-panel")

awesome.connect_signal("theme::reload", function()
  for k in pairs(package.loaded) do
    if k:match("^theme") then package.loaded[k] = nil end
  end
  require("theme")
  top_panel.reload()
  for s in screen do
    if s.selected_tag then
      s.selected_tag:emit_signal("property::layout")
    end
  end
  local beautiful = require("beautiful")

  for _, c in ipairs(client.get()) do
    if c.has_titlebar then
      awful.titlebar(c):set_bg(
        client.focus == c and beautiful.titlebar_bg_focus or beautiful.titlebar_bg_normal
      )
    end
  end
end)

require("modules")
require("modules.notifications")
require("modules.quake-terminal")
awful.spawn("autostart.sh")

require("rules")
require("tags")

require("keys")
