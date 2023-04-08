local awful = require("awful")
local conf_dir = awful.util.getdir("config")
package.path = package.path
  .. ";"
  .. conf_dir
  .. "/lib/?.lua;"
  .. conf_dir
  .. "/lib/?/init.lua"

require("theme")

require("utils")

require("widgets.top-panel")

require("modules")
require("modules.notifications")
require("modules.auto-start")
require("modules.quake-terminal")

require("rules")
require("tags")

require("keys")
