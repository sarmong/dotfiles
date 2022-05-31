local awful = require("awful")
local super = require("keys.mod").super
local alt = require("keys.mod").alt
local shift = require("keys.mod").shift

local local_keys = {
  awful.key({
    modifiers = { super },
    key = "m",
    on_press = function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    description = "toggle maximized",
    group = "client",
  }),
  awful.key({
    modifiers = { super },
    key = "f",
    description = "toggle float",
    group = "client",
    on_press = function(c)
      c.floating = not c.floating
      -- @TODO make window smaller
      awful.placement.centered(c)
      c:raise()
    end,
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "f",
    description = "toggle fullscreen",
    group = "client",
    on_press = function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "s",
    description = "toggle sticky",
    group = "client",
    on_press = function(c)
      c.sticky = not c.sticky
      c.ontop = not c.ontop
    end,
  }),
  awful.key({
    modifiers = { super },
    key = "q",
    description = "close client with confirmation",
    group = "client",
    on_press = function(c)
      awful.spawn.with_line_callback(
        "bash -c 'prompt-yn \"Kill " .. c.name .. "\"? '",
        {
          stdout = function(stdout)
            if stdout == "Yes" then
              c:kill()
            end
          end,
        }
      )
    end,
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "q",
    description = "close client without confirmation",
    group = "client",
    on_press = function(c)
      c:kill()
    end,
  }),
}

local global_keys = {
  awful.key({
    modifiers = { super, "Control" },
    key = "h",
    on_press = function()
      if client.focus then
        client.focus.minimized = true
      end
    end,
    description = "Minimize a client",
    group = "launcher",
  }),

  awful.key({
    modifiers = { super, "Control" },
    key = "n",
    on_press = function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        _G.client.focus = c
        c:raise()
      end
    end,
    description = "restore minimized",
    group = "client",
  }),

  -- Focus clients
  awful.key({
    modifiers = { super },
    key = "h",
    on_press = function()
      awful.client.focus.global_bydirection("left")
    end,
    description = "Focus client to the left",
    group = "client",
  }),
  awful.key({
    modifiers = { super },
    key = "j",
    on_press = function()
      awful.client.focus.global_bydirection("down")
    end,
    description = "Focus client below",
    group = "client",
  }),
  awful.key({
    modifiers = { super },
    key = "k",
    on_press = function()
      awful.client.focus.global_bydirection("up")
    end,
    description = "Focus client above",
    group = "client",
  }),
  awful.key({
    modifiers = { super },
    key = "l",
    on_press = function()
      awful.client.focus.global_bydirection("right")
    end,
    description = "Focus client to the right",
    group = "client",
  }),

  -- Swap clients
  awful.key({
    modifiers = { super, "Shift" },
    key = "h",
    on_press = function()
      awful.client.swap.global_bydirection("left")
    end,
    description = "Swap with client to the left",
    group = "client",
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "j",
    on_press = function()
      awful.client.swap.global_bydirection("down")
    end,
    description = "Swap with client below",
    group = "client",
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "k",
    on_press = function()
      awful.client.swap.global_bydirection("up")
    end,
    description = "Swap with client above",
    group = "client",
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "l",
    on_press = function()
      awful.client.swap.global_bydirection("right")
    end,
    description = "Swap with client to the right",
    group = "client",
  }),

  awful.key({
    modifiers = { super },
    key = "u",
    on_press = awful.client.urgent.jumpto,
    description = "jump to urgent client",
    group = "client",
  }),

  awful.key({
    modifiers = { super },
    key = "Tab",
    on_press = function()
      --awful.client.focus.history.previous()
      awful.client.focus.byidx(1)
      if _G.client.focus then
        _G.client.focus:raise()
      end
    end,
    description = "Switch to next window",
    group = "client",
  }),
  awful.key({
    modifiers = { super, "Shift" },
    key = "Tab",
    on_press = function()
      --awful.client.focus.history.previous()
      awful.client.focus.byidx(-1)
      if _G.client.focus then
        _G.client.focus:raise()
      end
    end,
    description = "Switch to previous window",
    group = "client",
  }),

  awful.key({
    modifiers = { alt, shift },
    key = "Right",
    on_press = function()
      awful.tag.incmwfact(0.05)
    end,
    description = "Increase master width factor",
    group = "layout",
  }),
  awful.key({
    modifiers = { alt, shift },
    key = "Left",
    on_press = function()
      awful.tag.incmwfact(-0.05)
    end,
    description = "Decrease master width factor",
    group = "layout",
  }),

  awful.key({
    modifiers = { alt, "Shift" },
    key = "Down",
    on_press = function()
      awful.client.incwfact(0.05)
    end,
    description = "Decrease master height factor",
    group = "layout",
  }),
  awful.key({
    modifiers = { alt, "Shift" },
    key = "Up",
    on_press = function()
      awful.client.incwfact(-0.05)
    end,
    description = "Increase master height factor",
    group = "layout",
  }),

  -- Screen management
  awful.key({
    modifiers = { super },
    key = "o",
    on_press = function()
      awful.screen.focus_relative(1)
    end,
    description = "Focus another screen",
  }),

  awful.key({
    modifiers = { super, "Shift" },
    key = "o",
    on_press = awful.client.movetoscreen,
    description = "move window to next screen",
    group = "client",
  }),
}

return {
  local_keys = local_keys,
  global_keys = global_keys,
}
