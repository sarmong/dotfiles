local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local modkey = require("configuration.keys.mod").modKey
local altkey = require("configuration.keys.mod").altKey
local apps = require("configuration.apps")
local exit_screen_show = require("module.exit-screen")
local tags = require("configuration.tags")

-- Key bindings
local globalKeys = awful.util.table.join(
  -- Hotkeys
  awful.key(
    { modkey },
    "F1",
    hotkeys_popup.show_help,
    { description = "Show help", group = "awesome" }
  ),
  -- Tag browsing
  awful.key(
    { modkey },
    "w",
    awful.tag.viewprev,
    { description = "view previous", group = "tag" }
  ),
  awful.key(
    { modkey },
    "s",
    awful.tag.viewnext,
    { description = "view next", group = "tag" }
  ),
  awful.key(
    { modkey },
    "Escape",
    awful.tag.history.restore,
    { description = "go back", group = "tag" }
  ),

  awful.key({ modkey, "Control" }, "h", function()
    if client.focus then
      client.focus.minimized = true
    end
  end, { description = "Minimize a client", group = "launcher" }),

  -- Focus clients
  -- @TODO consider using global_bydirection to focus across screens
  awful.key({ modkey }, "h", function()
    awful.client.focus.bydirection("left")
  end, { description = "Focus client to the left", group = "client" }),
  awful.key({ modkey }, "j", function()
    awful.client.focus.bydirection("down")
  end, { description = "Focus client below", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.bydirection("up")
  end, { description = "Focus client above", group = "client" }),
  awful.key({ modkey }, "l", function()
    awful.client.focus.bydirection("right")
  end, { description = "Focus client to the right", group = "client" }),

  -- Swap clients
  -- @TODO consider using global_bydirection to swap across screens
  awful.key({ modkey, "Shift" }, "h", function()
    awful.client.swap.bydirection("left")
  end, { description = "Swap with client to the left", group = "client" }),
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.bydirection("down")
  end, { description = "Swap with client below", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.bydirection("up")
  end, { description = "Swap with client above", group = "client" }),
  awful.key({ modkey, "Shift" }, "l", function()
    awful.client.swap.bydirection("right")
  end, { description = "Swap with client to the right", group = "client" }),

  -- Launchers
  awful.key({ modkey }, "e", function()
    awful.spawn("rofi -show drun")
  end, { description = "Rofi launcher", group = "awesome" }),
  awful.key({ altkey }, "space", function()
    awful.spawn("rofi -combi-modi window,drun -show combi -modi combi")
  end, { description = "Rofi launcher", group = "awesome" }),
  awful.key({ modkey }, "d", function()
    awful.spawn.with_shell("run_script")
  end, { description = "dmenu launcher", group = "awesome" }),
  awful.key({ modkey }, "b", function()
    awful.spawn.with_shell("bookmarks $XDG_NC_DIR/Documents/bookmarks.txt")
  end, { description = "bookmark selector", group = "awesome" }),
  awful.key({ modkey }, "c", function()
    awful.spawn.with_shell("rofi -show calc")
  end, { description = "Open dotfiles", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "d", function()
    awful.spawn.with_shell(
      "rofi -show power-menu -location 1 -yoffset 30 -xoffset 10 -width 15 -columns 1 -lines 6 -modi power-menu:$XDG_BIN_DIR/rofi/rofi-power-menu"
    )
  end, { description = "Power Menu", group = "awesome" }),
  awful.key({ modkey, "Control" }, "c", function()
    awful.spawn("copyq menu")
  end, { description = "Open clipboard menu", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "e", function()
    exit_screen_show()
  end, { description = "Log Out Screen", group = "awesome" }),
  awful.key(
    { modkey },
    "u",
    awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }
  ),
  awful.key({ modkey }, "Tab", function()
    --awful.client.focus.history.previous()
    awful.client.focus.byidx(1)
    if _G.client.focus then
      _G.client.focus:raise()
    end
  end, { description = "Switch to next window", group = "client" }),
  awful.key({ modkey, "Shift" }, "Tab", function()
    --awful.client.focus.history.previous()
    awful.client.focus.byidx(-1)
    if _G.client.focus then
      _G.client.focus:raise()
    end
  end, { description = "Switch to previous window", group = "client" }),

  -- Programms
  awful.key({}, "Print", function()
    awful.util.spawn_with_shell(apps.default.screenshot)
  end, {
    description = "Open screenshot utility",
    group = "screenshots (clipboard)",
  }),

  awful.key({ modkey, "Shift" }, "c", function()
    awful.spawn.with_shell(apps.default.config)
  end, { description = "Open dotfiles", group = "launcher" }),
  awful.key({ modkey }, "n", function()
    awful.spawn.with_shell(apps.default.notes)
  end, { description = "Open notes", group = "launcher" }),
  -- Standard program
  awful.key({ modkey }, "Return", function()
    awful.spawn(apps.default.terminal)
  end, { description = "Open a terminal", group = "launcher" }),
  awful.key(
    { modkey, "Control" },
    "r",
    _G.awesome.restart,
    { description = "reload awesome", group = "awesome" }
  ),
  awful.key(
    { modkey, "Control" },
    "q",
    _G.awesome.quit,
    { description = "quit awesome", group = "awesome" }
  ),
  awful.key({ altkey, "Shift" }, "Right", function()
    awful.tag.incmwfact(0.05)
  end, { description = "Increase master width factor", group = "layout" }),
  awful.key({ altkey, "Shift" }, "Left", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "Decrease master width factor", group = "layout" }),
  awful.key({ altkey, "Shift" }, "Down", function()
    awful.client.incwfact(0.05)
  end, { description = "Decrease master height factor", group = "layout" }),
  awful.key({ altkey, "Shift" }, "Up", function()
    awful.client.incwfact(-0.05)
  end, { description = "Increase master height factor", group = "layout" }),
  awful.key(
    { modkey, "Shift" },
    "Left",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    { description = "Increase the number of master clients", group = "layout" }
  ),
  awful.key(
    { modkey, "Shift" },
    "Right",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    { description = "Decrease the number of master clients", group = "layout" }
  ),
  awful.key({ modkey, "Control" }, "Left", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "Increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "Right", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "Decrease the number of columns", group = "layout" }),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "Select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "Select previous", group = "layout" }),
  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      _G.client.focus = c
      c:raise()
    end
  end, { description = "restore minimized", group = "client" }),

  -- Dropdown application
  awful.key({ modkey }, "z", function()
    _G.toggle_quake()
  end, { description = "dropdown application", group = "launcher" }),

  -- Brightness
  awful.key({}, "XF86MonBrightnessUp", function()
    awful.spawn("brightnessctl set +10%")
  end, { description = "Increase brightness +10%", group = "hotkeys" }),
  awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn("brightnessctl set 10%-")
  end, { description = "Decrease brightness -10%", group = "hotkeys" }),

  -- Volume control
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn("pulsemixer --change-volume +5")
  end, { description = "Volume up", group = "hotkeys" }),
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn("pulsemixer --change-volume -5")
  end, { description = "Volume down", group = "hotkeys" }),
  awful.key({}, "XF86AudioMute", function()
    awful.spawn("pulsemixer --toggle-mute")
  end, { description = "Toggle mute", group = "hotkeys" }),
  awful.key({}, "XF86AudioPlay", function()
    awful.spawn("playerctl play-pause")
  end, { description = "Play/Pause audio", group = "hotkeys" }),
  awful.key({}, "KP_End", function()
    awful.spawn("playerctl previous")
  end, { description = "1 -Previous track", group = "hotkeys" }),
  awful.key({}, "KP_Down", function()
    awful.spawn("playerctl --player=spotify play-pause")
  end, { description = "2 - Play/Pause spotify", group = "hotkeys" }),
  awful.key({}, "KP_Begin", function()
    awful.spawn("playerctl --player=firefox play-pause")
  end, { description = "5 - Play/Pause firefox", group = "hotkeys" }),
  awful.key({}, "KP_Up", function()
    awful.spawn("playerctl --player=mpv play-pause")
  end, { description = "8 - Play/Pause mpv", group = "hotkeys" }),
  awful.key({}, "KP_Next", function()
    awful.spawn("playerctl next")
  end, { description = "3 - Next track", group = "hotkeys" }),

  -- Screen management
  -- Go to next/prev screen
  awful.key({ modkey }, "o", function()
    awful.screen.focus_relative(1)
  end, { description = "Focus another screen" }),

  awful.key(
    { modkey, "Shift" },
    "o",
    awful.client.movetoscreen,
    { description = "move window to next screen", group = "client" }
  ),
  -- Open default program for tag
  awful.key(
    { modkey },
    "t",
    function()
      awful.spawn(awful.screen.focused().selected_tag.defaultApp, {
        tag = _G.mouse.screen.selected_tag,
        placement = awful.placement.bottom_right,
      })
    end,
    { description = "Open default program for tag/workspace", group = "tag" }
  ),
  -- Custom hotkeys
  -- Change keyboard layout
  awful.key({ modkey }, "/", function()
    awful.spawn.with_shell("$XDG_BIN_DIR/setup/keyboard/switch-layout.sh")
  end, { description = "Change keyboard layout", group = "hotkeys" })
  -- Emoji Picker
  -- awful.key(
  --   {modkey},
  --   'a',
  --   function()
  --     awful.util.spawn_with_shell('ibus emoji')
  --   end,
  --   {description = 'Open the ibus emoji picker to copy an emoji to your clipboard', group = 'hotkeys'}
  -- )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
--
for ordinal_index, current_tag in ipairs(tags) do
  local index = current_tag.index
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if index == 1 or index == 9 then
    descr_view = { description = "view tag #", group = "tag" }
    descr_toggle = { description = "toggle tag #", group = "tag" }
    descr_move = { description = "move focused client to tag #", group = "tag" }
    descr_toggle_focus = {
      description = "toggle focused client on tag #",
      group = "tag",
    }
  end
  globalKeys = awful.util.table.join(
    globalKeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. index + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[ordinal_index]
      if tag then
        tag:view_only()
      end
    end, descr_view),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. index + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, descr_toggle),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. index + 9, function()
      if _G.client.focus then
        local tag = _G.client.focus.screen.tags[index]
        if tag then
          _G.client.focus:move_to_tag(tag)
        end
      end
    end, descr_move),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. index + 9, function()
      if _G.client.focus then
        local tag = _G.client.focus.screen.tags[index]
        if tag then
          _G.client.focus:toggle_tag(tag)
        end
      end
    end, descr_toggle_focus)
  )
end

return globalKeys
