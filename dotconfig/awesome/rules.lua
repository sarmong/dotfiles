local awful = require("awful")
local ruled = require("ruled")

ruled.client.append_rules({
  {
    rule_any = { type = { "dialog" } },
    properties = { titlebars_enabled = true },
  },
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
    rule = { instance = "telegram", name = "Media viewer" },
    properties = {
      ontop = false,
      floating = false,
      titlebars_enabled = false,
    },
  },
  {
    rule = { instance = "caja", name = "File Operations" },
    properties = {
      placement = awful.placement.centered,
      ontop = true,
      floating = true,
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

local tags = require("tags")
for i, tag_def in ipairs(tags) do
  if tag_def.app_classes then
    ruled.client.append_rule({
      rule_any = { class = tag_def.app_classes },
      callback = function(c)
        local t = c.screen.tags[i]
        if not t then
          return
        end

        if tag_def.move_if_exists == false then
          for _, existing in ipairs(t:clients()) do
            if existing ~= c and existing.class == c.class then
              return
            end
          end
        end

        c:move_to_tag(t)
        if tag_def.switch_on_open then
          t:view_only()
        end
      end,
    })
  end
end
