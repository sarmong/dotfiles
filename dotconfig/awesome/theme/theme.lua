local filesystem = require("gears.filesystem")
local colors = require("theme.colors.gruvbox")
local theme_dir = filesystem.get_configuration_dir() .. "/theme"
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local theme = {

  font = "Roboto medium 10",
  icon_theme = "Papirus-Dark",

  --theme.wallpaper = theme_dir .. '/wallpapers/DarkCyan.png'
  wallpaper = "#e0e0e0",

  bg_normal = colors.dark1,
  bg_focus = "#5a5a5a",
  bg_urgent = "#3F3F3F",
  bg_minimize = "#444444",
  bg_systray = colors.dark1,

  fg_normal = "#ffffffde",
  fg_focus = "#e4e4e4",
  fg_urgent = "#CC9393",
  fg_minimize = "#ffffff",

  border_width = dpi(2),
  border_color_normal = colors.dark1,
  border_color_active = colors.light2,
  border_color_marked = "#CC9393",

  menu_height = dpi(16),
  menu_width = dpi(160),

  -- Tooltips
  tooltip_bg_color = "#232323",
  --theme.tooltip_border_color = '#232323'
  tooltip_border_width = 0,
  tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
  end,

  -- Layout
  layout_max = theme_dir .. "/icons/layouts/arrow-expand-all.png",
  layout_tile = theme_dir .. "/icons/layouts/view-quilt.png",

  -- Taglist
  taglist_bg_empty = colors.dark1,
  taglist_bg_occupied = colors.dark1,
  taglist_bg_urgent = "linear:0,0:"
    .. dpi(40)
    .. ",0:0,"
    .. colors.faded_red
    .. ":0.08,"
    .. colors.faded_red
    .. ":0.08,"
    .. colors.dark1
    .. ":1,"
    .. colors.dark1,
  taglist_bg_focus = "linear:0,0:"
    .. dpi(40)
    .. ",0:0,"
    .. colors.neutral_red
    .. ":0.08,"
    .. colors.neutral_red
    .. ":0.08,"
    .. colors.dark1
    .. ":1,"
    .. colors.dark1,

  -- Tasklist
  tasklist_font = "Roboto medium 11",
  tasklist_bg_normal = colors.dark1,
  tasklist_bg_focus = "linear:0,0:0,"
    .. dpi(40)
    .. ":0,"
    .. colors.dark1
    .. ":0.95,"
    .. colors.dark1
    .. ":0.95,"
    .. "#AAAAAA"
    .. ":1,"
    .. "#AAAAAA",
  tasklist_bg_urgent = colors.faded_green,
  tasklist_fg_focus = "#DDDDDD",
  tasklist_fg_urgent = "#AAAAAA",
  tasklist_fg_normal = "#AAAAAA",
}

return theme
