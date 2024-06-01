-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Material (Gogh)"
config.enable_tab_bar = false
config.check_for_updates = false
config.adjust_window_size_when_changing_font_size = false

config.font_size = 10
config.font = wezterm.font("FiraCode Nerd Font", {
  -- stretch = "Expanded",
})
config.line_height = 1.5
config.cell_width = 1

-- and finally, return the configuration to wezterm
return config
