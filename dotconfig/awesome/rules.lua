local awful = require("awful")

-- Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_offscreen,
      floating = false,
      maximized = false,
      above = false,
      below = false,
      ontop = false,
      sticky = false,
      maximized_horizontal = false,
      maximized_vertical = false,
    },
  },
  {
    rule_any = { name = { "QuakeTerminal" } },
    properties = { skip_decoration = true },
  },
  -- Titlebars
  {
    rule_any = {
      type = { "dialog" },
      class = { "Ulauncher", "Lxpolkit" },
    },
    properties = {
      placement = awful.placement.centered,
      ontop = true,
      floating = true,
      drawBackdrop = true,
      skip_decoration = true,
      border_width = 0,
    },
  },
  {
    rule_any = {
      type = { "utility" },
      class = { "PanGPUI" },
    },
    properties = {
      placement = awful.placement.top_right,
      ontop = true,
      floating = true,
      drawBackdrop = true,
      skip_decoration = true,
      sticky = true,
      border_width = 0,
    },
  },
  {
    rule_any = {
      class = {
        "Pavucontrol",
        "Nm-connection-editor",
        "Xfce4-power-manager-settings",
        "feh",
        "join*",
        "Blueman-manager",
      },
      name = { "pulsemixer" },
    },
    properties = {
      placement = awful.placement.centered,
      ontop = false,
      floating = true,
      skip_decoration = true,
    },
  },
  {
    rule = { instance = "Telegram" },
    except = { name = "Telegram*" },
    properties = {
      placement = awful.placement.centered,
      ontop = false,
      floating = true,
      skip_decoration = true,
    },
  },
  {
    rule = { instance = "telegram-desktop", name = "Media viewer" },
    properties = {
      placement = awful.placement.maximize,
      ontop = false,
      floating = false,
      skip_decoration = true,
    },
  },
  {
    -- Event Tester is xev
    rule_any = { name = { "dragon", "Event Tester" } },
    properties = {
      placement = awful.placement.top_right,
      ontop = true,
      floating = true,
      skip_decoration = true,
      sticky = true,
    },
  },
}