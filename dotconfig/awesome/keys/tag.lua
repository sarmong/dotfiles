local awful = require("awful")

local super = require("keys.mod").super
local ctrl = require("keys.mod").super
local shift = require("keys.mod").shift
local tags = require("tags")

local keys = {
  awful.key({
    modifiers = { super },
    key = "w",
    on_press = awful.tag.viewprev,
    description = "view previous",
    group = "tag",
  }),
  awful.key({
    modifiers = { super },
    key = "s",
    on_press = awful.tag.viewnext,
    description = "view next",
    group = "tag",
  }),
  awful.key({
    modifiers = { super },
    key = "Escape",
    on_press = awful.tag.history.restore,
    description = "go back",
    group = "tag",
  }),

  awful.key({
    modifiers = { super, "Shift" },
    key = "Left",
    on_press = function()
      awful.tag.incnmaster(1, nil, true)
    end,
    description = "Increase the number of master clients",
    group = "layout",
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "Right",
    on_press = function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    description = "Decrease the number of master clients",
    group = "layout",
  }),
  awful.key({
    modifiers = { super, "Control" },
    key = "Left",
    on_press = function()
      awful.tag.incncol(1, nil, true)
    end,
    description = "Increase the number of columns",
    group = "layout",
  }),
  awful.key({
    modifiers = { super, "Control" },
    key = "Right",
    on_press = function()
      awful.tag.incncol(-1, nil, true)
    end,
    description = "Decrease the number of columns",
    group = "layout",
  }),
  awful.key({
    modifiers = { super },
    key = "space",
    on_press = function()
      awful.layout.inc(1)
    end,
    description = "Select next layout",
    group = "layout",
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "space",
    on_press = function()
      awful.layout.inc(-1)
    end,
    description = "Select previous layout",
    group = "layout",
  }),
}

for ordinal_index, current_tag in ipairs(tags) do
  local index = current_tag.index

  keys = awful.util.table.join(
    keys,
    -- View tag only.
    {
      awful.key({
        modifiers = { super },
        key = "#" .. index + 9,
        on_press = function()
          local screen = awful.screen.focused()
          local tag = screen.tags[ordinal_index]
          if tag then
            tag:view_only()
          end
        end,
      }),
      -- Toggle tag display.
      awful.key({
        modifiers = { super, ctrl },
        key = "#" .. index + 9,
        on_press = function()
          local screen = awful.screen.focused()
          local tag = screen.tags[index]
          if tag then
            awful.tag.viewtoggle(tag)
          end
        end,
      }),
      -- Move client to tag.
      awful.key({
        modifiers = { super, shift },
        key = "#" .. index + 9,
        on_press = function()
          if _G.client.focus then
            local tag = _G.client.focus.screen.tags[ordinal_index]
            if tag then
              _G.client.focus:move_to_tag(tag)
            end
          end
        end,
      }),
      -- Toggle tag on focused client.
      awful.key({
        modifiers = { super, ctrl, shift },
        key = "#" .. index + 9,
        on_press = function()
          if _G.client.focus then
            local tag = _G.client.focus.screen.tags[ordinal_index]
            if tag then
              _G.client.focus:toggle_tag(tag)
            end
          end
        end,
      }),
    }
  )
end

return keys
