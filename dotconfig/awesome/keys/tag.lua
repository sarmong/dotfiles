local awful = require("awful")
local gears = require("gears")

local gen_keys = require("keys.gen-keys")
local super = require("keys.mod").super
local ctrl = require("keys.mod").ctrl
local shift = require("keys.mod").shift
local tags = require("tags")

local keys = {
  {
    description = "View previous tag",
    modifiers = { super },
    key = "w",
    on_press = awful.tag.viewprev,
    group = "tag",
  },
  {
    description = "View next tag",
    modifiers = { super },
    key = "s",
    on_press = awful.tag.viewnext,
    group = "tag",
  },
  {
    description = "Move client to the previous tag",
    modifiers = { super, shift },
    key = "w",
    on_press = function()
      local selected_tag = awful.screen.focused().selected_tag
      local selected_client = client.focus
      if selected_tag and selected_client then
        local all_tags = selected_client.screen.tags
        local tag = all_tags[selected_tag.index - 1] or all_tags[#all_tags]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
    group = "tag",
  },
  {
    description = "Move client to the next tag",
    modifiers = { super, shift },
    key = "s",
    on_press = function()
      local selected_tag = awful.screen.focused().selected_tag
      local selected_client = client.focus
      if selected_tag and selected_client then
        local all_tags = selected_client.screen.tags
        local tag = all_tags[selected_tag.index + 1] or all_tags[1]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
    group = "tag",
  },
  {
    description = "View previous tag",
    modifiers = { super },
    key = "Escape",
    on_press = function()
      awful.tag.history.restore()
    end,
    group = "tag",
  },

  {
    description = "Increase the number of master clients",
    modifiers = { super, shift },
    key = "Left",
    on_press = function()
      awful.tag.incnmaster(1, nil, true)
    end,
    group = "layout",
  },
  {
    description = "Decrease the number of master clients",
    modifiers = { super, shift },
    key = "Right",
    on_press = function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    group = "layout",
  },
  {
    description = "Increase the number of columns",
    modifiers = { super, ctrl },
    key = "Left",
    on_press = function()
      awful.tag.incncol(1, nil, true)
    end,
    group = "layout",
  },
  {
    description = "Decrease the number of columns",
    modifiers = { super, ctrl },
    key = "Right",
    on_press = function()
      awful.tag.incncol(-1, nil, true)
    end,
    group = "layout",
  },
  {
    modifiers = { super },
    key = "space",
    on_press = function()
      awful.layout.inc(1)
    end,
    description = "Select next layout",
    group = "layout",
  },
  {
    modifiers = { super, shift },
    key = "space",
    on_press = function()
      awful.layout.inc(-1)
    end,
    description = "Select previous layout",
    group = "layout",
  },
}

local number_keys = {}

for ordinal_index, current_tag in ipairs(tags) do
  local index = current_tag.index

  number_keys = gears.table.join(number_keys, {
    -- View tag only.
    {
      modifiers = { super },
      key = "#" .. index + 9,
      on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[ordinal_index]
        if tag then
          tag:view_only()
        end
      end,
    },
    -- Toggle tag display.
    {
      modifiers = { super, ctrl },
      key = "#" .. index + 9,
      on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
    },
    -- Move client to tag.
    {
      modifiers = { super, shift },
      key = "#" .. index + 9,
      on_press = function()
        if client.focus then
          local tag = client.focus.screen.tags[ordinal_index]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
    },
    -- Toggle tag on focused client.
    {
      modifiers = { super, ctrl, shift },
      key = "#" .. index + 9,
      on_press = function()
        if client.focus then
          local tag = client.focus.screen.tags[ordinal_index]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
    },

    {
      modifiers = { super },
      key = "#" .. ordinal_index + 9,
      on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[ordinal_index]
        if tag then
          tag:view_only()
        end
      end,
    },
    -- Toggle tag display.
    {
      modifiers = { super, ctrl },
      key = "#" .. ordinal_index + 9,
      on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
    },
    -- Move client to tag.
    {
      modifiers = { super, shift },
      key = "#" .. ordinal_index + 9,
      on_press = function()
        if client.focus then
          local tag = client.focus.screen.tags[ordinal_index]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
    },
    -- Toggle tag on focused client.
    {
      modifiers = { super, ctrl, shift },
      key = "#" .. ordinal_index + 9,
      on_press = function()
        if client.focus then
          local tag = client.focus.screen.tags[ordinal_index]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
    },
  })
end

return gen_keys(gears.table.join(keys, number_keys))
