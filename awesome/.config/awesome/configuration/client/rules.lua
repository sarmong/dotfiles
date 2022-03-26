local awful = require("awful")
local gears = require("gears")
local client_keys = require("configuration.client.keys")
local client_buttons = require("configuration.client.buttons")

-- Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      keys = client_keys,
      buttons = client_buttons,
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
    },
    properties = {
      placement = awful.placement.centered,
      ontop = true,
      floating = true,
      drawBackdrop = true,
      skip_decoration = true,
    },
  },
  {
    rule_any = { class = { "Pavucontrol" }, name = { "pulsemixer" } },
    properties = {
      placement = awful.placement.centered,
      ontop = false,
      floating = true,
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
    },
  },
}
