local naughty = require("naughty")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

-- Naughty presets
naughty.config.padding = 20
naughty.config.spacing = 20

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.font = "Roboto Regular 10"
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = 0
naughty.config.defaults.hover_timeout = nil
naughty.config.defaults.max_width = 500
