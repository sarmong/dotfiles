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

require("widgets.top-panel")

require("modules")
require("modules.notifications")
require("modules.quake-terminal")
awful.spawn("autostart.sh")

require("rules")
require("tags")

require("keys")
