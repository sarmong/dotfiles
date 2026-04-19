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
local titlebars = require("modules.titlebars")

awesome.connect_signal("theme::reload", function()
  for k in pairs(package.loaded) do
    if k:match("^theme") then
      package.loaded[k] = nil
    end
  end
  require("theme")
  top_panel.reload()
  for s in screen do
    if s.selected_tag then
      s.selected_tag:emit_signal("property::layout")
    end
  end
  titlebars.update_colors()
end)

require("modules")
require("modules.notifications")
require("modules.quake-terminal")
awful.spawn("autostart.sh")

require("rules")
require("tags")

require("keys")
