local awful = require("awful")
local lain = require("lain")
local icons = require("theme.icons")

local tags = {
  {
    icon = icons.firefox,
    type = "browser",
    -- screen = 1,
    index = 1,
    get_default_app = function()
      return os.getenv("BROWSER")
    end,
  },
  {
    icon = icons.code,
    type = "code",
    -- screen = 1,
    index = 2,
    get_default_app = function()
      return os.getenv("TERMINAL")
    end,
  },
  {
    icon = icons.code,
    type = "code2",
    -- screen = 1,
    index = 3,
    get_default_app = function()
      return os.getenv("TERMINAL")
    end,
  },
  {
    icon = icons.folder,
    type = "files",
    -- screen = 1,
    index = 8,
    get_default_app = function()
      return "thunar"
    end,
  },
  {
    icon = icons.social,
    type = "social",
    -- screen = 1,
    index = 9,
    get_default_app = function()
      return "telegram-desktop"
    end,
  },
  {
    icon = icons.music,
    type = "music",
    -- screen = 1,
    index = 10,
    get_default_app = function()
      return "slack"
    end,
  },
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  lain.layout.centerwork,
  awful.layout.suit.floating,
}

-- Create tags in a stable order: internal display (eDP-*, LVDS-*) first, external after.
-- RandR enumerates primary first, which changes on every primary switch —
-- output-name ordering gives stable _NET_WM_DESKTOP values across restarts
-- regardless of physical monitor position or which screen is primary.
local function setup_screen_tags(s)
  for i, tag in pairs(tags) do
    awful.tag.add(i, {
      icon = tag.icon,
      icon_only = true,
      layout = awful.layout.suit.tile,
      gap_single_client = false,
      gap = 4,
      screen = s,
      get_default_app = tag.get_default_app,
      selected = i == 1,
    })
  end
end
local function is_internal(s)
  for name in pairs(s.outputs) do
    if name:match("^eDP") or name:match("^LVDS") then
      return true
    end
  end
  return false
end

local screens_sorted = {}
for s in screen do
  table.insert(screens_sorted, s)
end
table.sort(screens_sorted, function(a, b)
  return is_internal(a) and not is_internal(b)
end)
for _, s in ipairs(screens_sorted) do
  setup_screen_tags(s)
end

screen.connect_signal("added", setup_screen_tags)

tag.connect_signal("property::layout", function(t)
  local currentLayout = awful.tag.getproperty(t, "layout")
  if currentLayout == awful.layout.suit.max then
    t.gap = 0
  else
    t.gap = 4
  end
end)

return tags
