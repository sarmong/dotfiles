local awful = require("awful")

local super = require("keys.mod").super
local alt = require("keys.mod").alt
local exit_screen_show = require("modules.exit-screen")

local group_name = "apps"

local keys = {
  awful.key({
    description = "Rofi launcher",
    modifiers = { super },
    key = "e",
    on_press = function()
      awful.spawn("rofi -show drun")
    end,
    group = group_name,
  }),
  awful.key({
    description = "Rofi launcher",
    modifiers = { alt },
    key = "space",
    on_press = function()
      awful.spawn("rofi -combi-modi window,drun -show combi -modi combi")
    end,
    group = group_name,
  }),
  awful.key({
    description = "dmenu launcher",
    modifiers = { super },
    key = "d",
    on_press = function()
      awful.spawn.with_shell("run_script")
    end,
    group = group_name,
  }),
  awful.key({
    description = "bookmark selector",
    modifiers = { super },
    key = "b",
    on_press = function()
      awful.spawn.with_shell("bookmarks $XDG_NC_DIR/Documents/bookmarks.txt")
    end,
    group = group_name,
  }),
  awful.key({
    description = "Calculator",
    modifiers = { super },
    key = "c",
    on_press = function()
      awful.spawn.with_shell("rofi -show calc")
    end,
    group = group_name,
  }),
  awful.key({
    description = "Power Menu",
    modifiers = { super, "Shift" },
    key = "d",
    on_press = function()
      awful.spawn.with_shell(
        "rofi -show power-menu -location 1 -yoffset 30 -xoffset 10 -width 15 -columns 1 -lines 6 -modi power-menu:$XDG_BIN_DIR/rofi/rofi-power-menu"
      )
    end,
    group = group_name,
  }),
  awful.key({
    description = "Log Out Screen",
    modifiers = { super, "Shift" },
    key = "e",
    on_press = function()
      exit_screen_show()
    end,
    group = group_name,
  }),
  awful.key({
    description = "Open clipboard menu",
    modifiers = { super, "Control" },
    key = "c",
    on_press = function()
      awful.spawn.with_shell("CM_LAUNCHER=rofi clipmenu")
    end,
    group = group_name,
  }),

  awful.key({
    description = "Open screenshot utility",
    modifiers = { super },
    key = "p",
    on_press = function()
      awful.util.spawn_with_shell("flameshot gui")
    end,
    group = group_name,
  }),

  awful.key({
    description = "Open dotfiles",
    modifiers = { super, "Shift" },
    key = "c",
    on_press = function()
      awful.spawn.with_shell(
        "alacritty --working-directory $XDG_DOTFILES_DIR -e $SHELL -c 'nvim ; $SHELL'"
      )
    end,
    group = group_name,
  }),
  awful.key({
    description = "Open notes",
    modifiers = { super },
    key = "n",
    on_press = function()
      awful.spawn.with_shell(
        "alacritty --working-directory $XDG_NC_DIR/Vault -e $SHELL -c 'nvim ; $SHELL'"
      )
    end,
    group = group_name,
  }),
  awful.key({
    description = "Open a terminal",
    modifiers = { super },
    key = "Return",
    on_press = function()
      awful.spawn("alacritty")
    end,
    group = group_name,
  }),

  awful.key({
    description = "dropdown terminal",
    modifiers = { super },
    key = "z",
    on_press = function()
      _G.toggle_quake()
    end,
    group = group_name,
  }),
}

return keys
