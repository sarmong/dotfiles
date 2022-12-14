local awful = require("awful")
local icons = require("theme.icons")

local tags = {
  {
    icon = icons.chrome,
    type = "chrome",
    screen = 1,
    index = 1,
  },
  {
    icon = icons.code,
    type = "code",
    screen = 1,
    index = 2,
  },
  {
    icon = icons.code,
    type = "code2code2",
    screen = 1,
    index = 3,
  },
  {
    icon = icons.folder,
    type = "files",
    screen = 1,
    index = 8,
  },
  {
    icon = icons.social,
    type = "social",
    screen = 1,
    index = 9,
  },
  {
    icon = icons.music,
    type = "music",
    screen = 1,
    index = 10,
  },
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.corner.nw,
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
      defaultApp = tag.defaultApp,
      selected = i == 1,
    })
  end
end)

_G.tag.connect_signal("property::layout", function(t)
  local currentLayout = awful.tag.getproperty(t, "layout")
  if currentLayout == awful.layout.suit.max then
    t.gap = 0
  else
    t.gap = 4
  end
end)

return tags
