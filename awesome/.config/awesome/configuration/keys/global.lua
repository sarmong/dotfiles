local awful = require("awful")
require("awful.autofocus")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local revelation = require("lib.revelation")

local modkey = require("configuration.keys.mod").modKey
local altkey = require("configuration.keys.mod").altKey
local apps = require("configuration.apps")
local exit_screen_show = require("module.exit-screen")
local tags = require("configuration.tags")

-- Key bindings
local globalKeys = {
  awful.key({
    modifiers = { modkey },
    key = "F1",
    on_press = hotkeys_popup.show_help,
    description = "Show help",
    group = "awesome",
  }),
  -- Tag browsing
  awful.key({
    modifiers = { modkey },
    key = "w",
    on_press = awful.tag.viewprev,
    description = "view previous",
    group = "tag",
  }),
  awful.key({
    modifiers = { modkey },
    key = "s",
    on_press = awful.tag.viewnext,
    description = "view next",
    group = "tag",
  }),
  awful.key({
    modifiers = { modkey },
    key = "Escape",
    on_press = awful.tag.history.restore,
    description = "go back",
    group = "tag",
  }),

  awful.key({
    modifiers = { modkey, "Control" },
    key = "h",
    on_press = function()
      if client.focus then
        client.focus.minimized = true
      end
    end,
    description = "Minimize a client",
    group = "launcher",
  }),

  -- Focus clients
  -- @TODO consider using global_bydirection to focus across screens
  awful.key({
    modifiers = { modkey },
    key = "h",
    on_press = function()
      awful.client.focus.bydirection("left")
    end,
    description = "Focus client to the left",
    group = "client",
  }),
  awful.key({
    modifiers = { modkey },
    key = "j",
    on_press = function()
      awful.client.focus.bydirection("down")
    end,
    description = "Focus client below",
    group = "client",
  }),
  awful.key({
    modifiers = { modkey },
    key = "k",
    on_press = function()
      awful.client.focus.bydirection("up")
    end,
    description = "Focus client above",
    group = "client",
  }),
  awful.key({
    modifiers = { modkey },
    key = "l",
    on_press = function()
      awful.client.focus.bydirection("right")
    end,
    description = "Focus client to the right",
    group = "client",
  }),

  -- Swap clients
  -- @TODO consider using global_bydirection to swap across screens
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "h",
    on_press = function()
      awful.client.swap.bydirection("left")
    end,
    description = "Swap with client to the left",
    group = "client",
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "j",
    on_press = function()
      awful.client.swap.bydirection("down")
    end,
    description = "Swap with client below",
    group = "client",
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "k",
    on_press = function()
      awful.client.swap.bydirection("up")
    end,
    description = "Swap with client above",
    group = "client",
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "l",
    on_press = function()
      awful.client.swap.bydirection("right")
    end,
    description = "Swap with client to the right",
    group = "client",
  }),

  -- Launchers
  awful.key({
    modifiers = { modkey },
    key = "e",
    on_press = function()
      awful.spawn("rofi -show drun")
    end,
    description = "Rofi launcher",
    group = "awesome",
  }),
  awful.key({
    modifiers = { altkey },
    key = "space",
    on_press = function()
      awful.spawn("rofi -combi-modi window,drun -show combi -modi combi")
    end,
    description = "Rofi launcher",
    group = "awesome",
  }),
  awful.key({
    modifiers = { modkey },
    key = "d",
    on_press = function()
      awful.spawn.with_shell("run_script")
    end,
    description = "dmenu launcher",
    group = "awesome",
  }),
  awful.key({
    modifiers = { modkey },
    key = "b",
    on_press = function()
      awful.spawn.with_shell("bookmarks $XDG_NC_DIR/Documents/bookmarks.txt")
    end,
    description = "bookmark selector",
    group = "awesome",
  }),
  awful.key({
    modifiers = { modkey },
    key = "c",
    on_press = function()
      awful.spawn.with_shell("rofi -show calc")
    end,
    description = "Open dotfiles",
    group = "launcher",
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "d",
    on_press = function()
      awful.spawn.with_shell(
        "rofi -show power-menu -location 1 -yoffset 30 -xoffset 10 -width 15 -columns 1 -lines 6 -modi power-menu:$XDG_BIN_DIR/rofi/rofi-power-menu"
      )
    end,
    description = "Power Menu",
    group = "awesome",
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "c",
    on_press = function()
      awful.spawn.with_shell("CM_LAUNCHER=rofi clipmenu")
    end,
    description = "Open clipboard menu",
    group = "awesome",
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "e",
    on_press = function()
      exit_screen_show()
    end,
    description = "Log Out Screen",
    group = "awesome",
  }),

  awful.key({
    modifiers = { modkey },
    key = "r",
    on_press = revelation,
    description = "open revelation",
  }),
  awful.key({
    modifiers = { modkey },
    key = "u",
    on_press = awful.client.urgent.jumpto,
    description = "jump to urgent client",
    group = "client",
  }),
  awful.key({
    modifiers = { modkey },
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
    modifiers = { modkey, "Shift" },
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

  -- Programms
  awful.key({
    modifiers = {},
    key = "Print",
    on_press = function()
      awful.util.spawn_with_shell(apps.default.screenshot)
    end,
    description = "Open screenshot utility",
    group = "screenshots (clipboard)",
  }),

  awful.key({
    modifiers = { modkey, "Shift" },
    key = "c",
    on_press = function()
      awful.spawn.with_shell(apps.default.config)
    end,
    description = "Open dotfiles",
    group = "launcher",
  }),
  awful.key({
    modifiers = { modkey },
    key = "n",
    on_press = function()
      awful.spawn.with_shell(apps.default.notes)
    end,
    description = "Open notes",
    group = "launcher",
  }),
  awful.key({
    modifiers = { modkey },
    key = "Return",
    on_press = function()
      awful.spawn(apps.default.terminal)
    end,
    description = "Open a terminal",
    group = "launcher",
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "r",
    on_press = _G.awesome.restart,
    description = "reload awesome",
    group = "awesome",
  }),
  awful.key({
    modifiers = { modkey, "Shift", "Control" },
    key = "q",
    on_press = _G.awesome.quit,
    description = "quit awesome",
    group = "awesome",
  }),
  awful.key({
    modifiers = { altkey, "Shift" },
    key = "Right",
    on_press = function()
      awful.tag.incmwfact(0.05)
    end,
    description = "Increase master width factor",
    group = "layout",
  }),
  awful.key({
    modifiers = { altkey, "Shift" },
    key = "Left",
    on_press = function()
      awful.tag.incmwfact(-0.05)
    end,
    description = "Decrease master width factor",
    group = "layout",
  }),
  awful.key({
    modifiers = { altkey, "Shift" },
    key = "Down",
    on_press = function()
      awful.client.incwfact(0.05)
    end,
    description = "Decrease master height factor",
    group = "layout",
  }),
  awful.key({
    modifiers = { altkey, "Shift" },
    key = "Up",
    on_press = function()
      awful.client.incwfact(-0.05)
    end,
    description = "Increase master height factor",
    group = "layout",
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "Left",
    on_press = function()
      awful.tag.incnmaster(1, nil, true)
    end,
    description = "Increase the number of master clients",
    group = "layout",
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "Right",
    on_press = function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    description = "Decrease the number of master clients",
    group = "layout",
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "Left",
    on_press = function()
      awful.tag.incncol(1, nil, true)
    end,
    description = "Increase the number of columns",
    group = "layout",
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "Right",
    on_press = function()
      awful.tag.incncol(-1, nil, true)
    end,
    description = "Decrease the number of columns",
    group = "layout",
  }),
  awful.key({
    modifiers = { modkey },
    key = "space",
    on_press = function()
      awful.layout.inc(1)
    end,
    description = "Select next",
    group = "layout",
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "space",
    on_press = function()
      awful.layout.inc(-1)
    end,
    description = "Select previous",
    group = "layout",
  }),
  awful.key({
    modifiers = { modkey, "Control" },
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

  -- Dropdown application
  awful.key({
    modifiers = { modkey },
    key = "z",
    on_press = function()
      _G.toggle_quake()
    end,
    description = "dropdown application",
    group = "launcher",
  }),

  -- Brightness
  awful.key({
    modifiers = {},
    key = "XF86MonBrightnessUp",
    on_press = function()
      awful.spawn("brightnessctl set +10%")
    end,
    description = "Increase brightness +10%",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "XF86MonBrightnessDown",
    on_press = function()
      awful.spawn("brightnessctl set 10%-")
    end,
    description = "Decrease brightness -10%",
    group = "hotkeys",
  }),

  -- Volume control
  awful.key({
    modifiers = {},
    key = "XF86AudioRaiseVolume",
    on_press = function()
      awful.spawn("pulsemixer --change-volume +5")
    end,
    description = "Volume up",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioLowerVolume",
    on_press = function()
      awful.spawn("pulsemixer --change-volume -5")
    end,
    description = "Volume down",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioMute",
    on_press = function()
      awful.spawn("pulsemixer --toggle-mute")
    end,
    description = "Toggle mute",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioPlay",
    on_press = function()
      awful.spawn("playerctl play-pause")
    end,
    description = "Play/Pause audio",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "KP_End",
    on_press = function()
      awful.spawn("playerctl previous")
    end,
    description = "1 -Previous track",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "KP_Down",
    on_press = function()
      awful.spawn("playerctl --player=spotify play-pause")
    end,
    description = "2 - Play/Pause spotify",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "KP_Begin",
    on_press = function()
      awful.spawn("playerctl --player=firefox play-pause")
    end,
    description = "5 - Play/Pause firefox",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "KP_Up",
    on_press = function()
      awful.spawn("playerctl --player=mpv play-pause")
    end,
    description = "8 - Play/Pause mpv",
    group = "hotkeys",
  }),
  awful.key({
    modifiers = {},
    key = "KP_Next",
    on_press = function()
      awful.spawn("playerctl next")
    end,
    description = "3 - Next track",
    group = "hotkeys",
  }),

  -- Screen management
  -- Go to next/prev screen
  awful.key({
    modifiers = { modkey },
    key = "o",
    on_press = function()
      awful.screen.focus_relative(1)
    end,
    description = "Focus another screen",
  }),

  awful.key({
    modifiers = { modkey, "Shift" },
    key = "o",
    on_press = awful.client.movetoscreen,
    description = "move window to next screen",
    group = "client",
  }),
  -- Open default program for tag
  awful.key({
    modifiers = { modkey },
    key = "t",
    on_press = function()
      awful.spawn(awful.screen.focused().selected_tag.defaultApp, {
        tag = _G.mouse.screen.selected_tag,
        placement = awful.placement.bottom_right,
      })
    end,
    description = "Open default program for tag/workspace",
    group = "tag",
  }),
  -- Custom hotkeys
  -- Change keyboard layout
  awful.key({
    modifiers = { modkey },
    key = "/",
    on_press = function()
      awful.spawn.with_shell("$XDG_BIN_DIR/setup/keyboard/switch-layout.sh")
    end,
    description = "Change keyboard layout",
    group = "hotkeys",
  }),
  -- Emoji Picker
  awful.key({
    modifiers = { modkey },
    key = "a",
    on_press = function()
      awful.util.spawn_with_shell("ibus emoji")
    end,
    description = "Open the ibus emoji picker to copy an emoji to your clipboard",
    group = "hotkeys",
  }),
}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
--
for ordinal_index, current_tag in ipairs(tags) do
  local index = current_tag.index

  globalKeys = awful.util.table.join(
    globalKeys,
    -- View tag only.
    {
      awful.key({
        modifiers = { modkey },
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
        modifiers = { modkey, "Control" },
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
        modifiers = { modkey, "Shift" },
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
        modifiers = { modkey, "Control", "Shift" },
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

awful.keyboard.append_global_keybindings(globalKeys)
