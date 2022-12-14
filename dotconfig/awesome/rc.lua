local beautiful = require("beautiful")

beautiful.init(require("theme"))

require("utils")

require("widgets.top-panel")

require("modules")
require("modules.notifications")
require("modules.auto-start")
require("modules.quake-terminal")

require("rules")
require("tags")

require("keys")
