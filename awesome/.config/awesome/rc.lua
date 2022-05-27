local awful = require("awful")
local beautiful = require("beautiful")

beautiful.init(require("theme"))

require("utils.log")

require("layout")

require("module.notifications")
require("module.auto-start")
require("module.quake-terminal")

-- Setup all configurations
require("configuration.client")
require("configuration.tags")

require("configuration.keys")
