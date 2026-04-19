local filesystem = require("gears.filesystem")
local colors = require("theme.colors.current")
local theme_dir = filesystem.get_configuration_dir() .. "/theme"
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local theme = {

  font = "Roboto medium 10",
  icon_theme = "Papirus-Dark",

  --theme.wallpaper = theme_dir .. '/wallpapers/DarkCyan.png'
  wallpaper = colors.theme_wallpaper,

  bg_normal = colors.dark1,
  bg_focus = colors.theme_bg_focus,
  bg_urgent = colors.theme_bg_urgent,
  bg_minimize = colors.theme_bg_minimize,
  bg_systray = colors.dark1,

  fg_normal = colors.theme_fg,
  fg_focus = colors.theme_fg_focus,
  fg_urgent = colors.theme_fg_urgent,
  fg_minimize = colors.theme_fg_minimize,

  titlebar_bg_normal = colors.dark1,
  titlebar_bg_focus = colors.dark2,
  titlebar_fg_normal = colors.theme_titlebar_fg_normal,
  titlebar_fg_focus = colors.theme_titlebar_fg_focus,
  titlebar_button_hover_bg = colors.dark3,
  titlebar_close_hover_bg = colors.neutral_red,

  border_width = dpi(2),
  border_color_normal = colors.dark1,
  border_color_active = colors.light2,
  border_color_marked = colors.theme_fg_urgent,

  menu_height = dpi(16),
  menu_width = dpi(160),

  -- Tooltips
  tooltip_bg_color = colors.theme_tooltip_bg,
  --theme.tooltip_border_color = '#232323'
  tooltip_border_width = 0,
  tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
  end,

  -- Layout
  layout_max = gears.color.recolor_image(theme_dir .. "/icons/layouts/arrow-expand-all.png", colors.theme_fg),
  layout_tile = gears.color.recolor_image(theme_dir .. "/icons/layouts/view-quilt.png", colors.theme_fg),

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
    .. colors.faded_aqua
    .. ":0.08,"
    .. colors.faded_aqua
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
    .. colors.theme_tasklist_separator
    .. ":1,"
    .. colors.theme_tasklist_separator,
  tasklist_bg_urgent = colors.faded_green,
  tasklist_fg_focus = colors.theme_tasklist_fg_focus,
  tasklist_fg_urgent = colors.theme_tasklist_fg_urgent,
  tasklist_fg_normal = colors.theme_tasklist_fg_normal,
}

return theme
