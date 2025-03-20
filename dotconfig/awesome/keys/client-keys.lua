local awful = require("awful")

local gen_keys = require("keys.gen-keys")
local super = require("keys.mod").super
local alt = require("keys.mod").alt
local shift = require("keys.mod").shift
local ctrl = require("keys.mod").ctrl

local local_keys = {
  -- Focus clients
  {
    description = "Focus client to the left",
    modifiers = { super },
    key = "h",
    on_press = function()
      awful.client.focus.global_bydirection("left")
    end,
    group = "client",
  },
  {
    description = "Focus client below",
    modifiers = { super },
    key = "j",
    on_press = function()
      awful.client.focus.global_bydirection("down")
    end,
    group = "client",
  },
  {
    description = "Focus client above",
    modifiers = { super },
    key = "k",
    on_press = function()
      awful.client.focus.global_bydirection("up")
    end,
    group = "client",
  },
  {
    description = "Focus client to the right",
    modifiers = { super },
    key = "l",
    on_press = function()
      awful.client.focus.global_bydirection("right")
    end,
    group = "client",
  },

  -- Swap clients
  {
    description = "Swap with client to the left",
    modifiers = { super, shift },
    key = "h",
    on_press = function()
      awful.client.swap.global_bydirection("left")
    end,
    group = "client",
  },
  {
    description = "Swap with client below",
    modifiers = { super, shift },
    key = "j",
    on_press = function()
      awful.client.swap.global_bydirection("down")
    end,
    group = "client",
  },
  {
    description = "Swap with client above",
    modifiers = { super, shift },
    key = "k",
    on_press = function()
      awful.client.swap.global_bydirection("up")
    end,
    group = "client",
  },
  {
    description = "Swap with client to the right",
    modifiers = { super, shift },
    key = "l",
    on_press = function()
      awful.client.swap.global_bydirection("right")
    end,
    group = "client",
  },

  {
    description = "toggle maximized",
    modifiers = { super },
    key = "m",
    on_press = function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    group = "client",
  },
  {
    description = "toggle float",
    modifiers = { super },
    key = "f",
    group = "client",
    on_press = function(c)
      c.floating = not c.floating
      -- @TODO make window smaller
      awful.placement.centered(c)
      c:raise()
    end,
  },
  {
    description = "toggle fullscreen",
    modifiers = { super, shift },
    key = "f",
    group = "client",
    on_press = function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
  },
  {
    description = "toggle sticky",
    modifiers = { super, ctrl },
    key = "s",
    group = "client",
    on_press = function(c)
      c.sticky = not c.sticky
      c.ontop = not c.ontop
    end,
  },
  {
    description = "close client with confirmation",
    modifiers = { super },
    key = "q",
    group = "client",
    on_press = function(c)
      awful.spawn.with_line_callback(
        "bash -c 'prompt \"Kill " .. c.name .. "\"? '",
        {
          stdout = function(stdout)
            if stdout == "Yes" then
              c:kill()
            end
          end,
        }
      )
    end,
  },
  {
    description = "close client without confirmation",
    modifiers = { super, shift },
    key = "q",
    group = "client",
    on_press = function(c)
      c:kill()
    end,
  },
  {
    description = "Minimize a client",
    modifiers = { super, ctrl },
    key = "h",
    on_press = function()
      if client.focus then
        client.focus.minimized = true
      end
    end,
    group = "client",
  },
  {
    description = "Switch to next window",
    modifiers = { super },
    key = "Tab",
    on_press = function()
      --awful.client.focus.history.previous()
      awful.client.focus.byidx(1)
      if client.focus then
        client.focus:raise()
      end
    end,
    group = "client",
  },
  {
    description = "Switch to previous window",
    modifiers = { super, shift },
    key = "Tab",
    on_press = function()
      --awful.client.focus.history.previous()
      awful.client.focus.byidx(-1)
      if client.focus then
        client.focus:raise()
      end
    end,
    group = "client",
  },

  {
    description = "move window to next screen",
    modifiers = { super, shift },
    key = "o",
    on_press = function(c)
      c:move_to_screen()
    end,
    group = "client",
  },
  {
    description = "move window to next screen to the same tag",
    modifiers = { super, ctrl },
    key = "o",
    on_press = function(c)
      local alt_screen = require("modules.move-windows").find_alt_screen(c.screen)
      c:move_to_tag(alt_screen.tags[c.first_tag.index])
    end,
    group = "client",
  },
}

local global_keys = {
  {
    description = "restore minimized",
    modifiers = { super, ctrl },
    key = "n",
    on_press = function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    group = "client",
  },

  {
    description = "jump to urgent client",
    modifiers = { super },
    key = "u",
    on_press = awful.client.urgent.jumpto,
    group = "client",
  },

  {
    description = "Increase master width factor",
    modifiers = { super },
    key = "Right",
    on_press = function()
      awful.tag.incmwfact(0.05)
    end,
    group = "layout",
  },
  {
    description = "Decrease master width factor",
    modifiers = { super },
    key = "Left",
    on_press = function()
      awful.tag.incmwfact(-0.05)
    end,
    group = "layout",
  },

  {
    description = "Decrease master height factor",
    modifiers = { super },
    key = "Down",
    on_press = function()
      awful.client.incwfact(0.05)
    end,
    group = "layout",
  },
  {
    description = "Increase master height factor",
    modifiers = { super },
    key = "Up",
    on_press = function()
      awful.client.incwfact(-0.05)
    end,
    group = "layout",
  },

  -- Screen management
  {
    description = "Focus another screen",
    modifiers = { super },
    key = "o",
    on_press = function()
      awful.screen.focus_relative(1)
    end,
  },
}

return {
  local_keys = gen_keys(local_keys),
  global_keys = gen_keys(global_keys),
}
