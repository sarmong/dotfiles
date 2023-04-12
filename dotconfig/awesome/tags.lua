local awful = require("awful")
local lain = require("lain")
local icons = require("theme.icons")

local tags = {
  {
    icon = icons.firefox,
    type = "browser",
    screen = 1,
    index = 1,
    get_default_app = function()
      return os.getenv("BROWSER")
    end,
  },
  {
    icon = icons.code,
    type = "code",
    screen = 1,
    index = 2,
    get_default_app = function()
      return os.getenv("TERMINAL")
    end,
  },
  {
    icon = icons.code,
    type = "code2",
    screen = 1,
    index = 3,
    get_default_app = function()
      return os.getenv("TERMINAL")
    end,
  },
  {
    icon = icons.folder,
    type = "files",
    screen = 1,
    index = 8,
    get_default_app = function()
      return "thunar"
    end,
  },
  {
    icon = icons.social,
    type = "social",
    screen = 1,
    index = 9,
    get_default_app = function()
      return "telegram-desktop"
    end,
  },
  {
    icon = icons.music,
    type = "music",
    screen = 1,
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
}

awful.screen.connect_for_each_screen(function(s)
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
end)

tag.connect_signal("property::layout", function(t)
  local currentLayout = awful.tag.getproperty(t, "layout")
  if currentLayout == awful.layout.suit.max then
    t.gap = 0
  else
    t.gap = 4
  end
end)

return tags
