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

-- if there is an activated client - focus it when switching to its tag
-- handles the issue when activated client goes on top, but another client is focused in maximised layouts
local pending_focus = {}
client.connect_signal("request::activate", function(c)
  local t = c.first_tag
  if t and not t.selected then
    pending_focus[t] = c
  end
end)
tag.connect_signal("property::selected", function(t)
  if t.selected and pending_focus[t] then
    local c = pending_focus[t]
    pending_focus[t] = nil
    if c.valid then
      client.focus = c
      c:raise()
    end
  end
end)

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
