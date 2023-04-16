local awful = require("awful")
local ruled = require("ruled")

ruled.client.append_rules({
  {
    -- All clients will match this rule.
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
    rule_any = {
      type = { "dialog" },
      class = { "Ulauncher", "Lxpolkit" },
    },
    properties = {
      placement = awful.placement.centered,
      ontop = true,
      floating = true,
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
        "zoom",
        "Blueman-manager",
      },
      name = { "pulsemixer" },
    },
    properties = {
      placement = awful.placement.centered,
      ontop = false,
      floating = true,
    },
  },
  {
    rule = { instance = "Telegram" },
    except = { name = "Telegram*" },
    properties = {
      placement = awful.placement.centered,
      ontop = false,
      floating = true,
    },
  },
  {
    rule = { instance = "telegram-desktop", name = "Media viewer" },
    properties = {
      placement = awful.placement.maximize,
      ontop = false,
      floating = false,
    },
  },
  {
    -- Event Tester is xev
    rule_any = { name = { "dragon", "Event Tester" } },
    properties = {
      placement = awful.placement.top_right,
      ontop = true,
      floating = true,
      sticky = true,
    },
  },

  -- Utility classes
  {
    rule_any = { class = { "centered" } },
    properties = {
      placement = awful.placement.centered,
      ontop = true,
      floating = true,
      width = 1100,
      height = 600,
    },
  },
})
