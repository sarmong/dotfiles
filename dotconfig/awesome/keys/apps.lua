local awful = require("awful")

local gen_keys = require("keys.gen-keys")
local super = require("keys.mod").super
local ctrl = require("keys.mod").ctrl
local shift = require("keys.mod").shift
-- local exit_screen_show = require("modules.exit-screen")
local quake = require("modules.quake-terminal")

local group_name = "apps"

local keys = {
  {
    description = "Open dropdown terminal",
    modifiers = { super },
    key = "z",
    on_press = function()
      quake.scratch:close()
      quake.dropdown:toggle()
    end,
  },
  {
    description = "Open scratchpad",
    modifiers = { super },
    key = "a",
    on_press = function()
      quake.dropdown:close()
      quake.scratch:toggle()
    end,
  },

  -- {
  --   description = "Open a terminal",
  --   modifiers = { super },
  --   key = "Return",
  --   on_press = function()
  --     awful.spawn.with_shell("$TERMINAL || kitty || alacritty || st")
  --   end,
  -- },
  -- {
  --   description = "Open a centered terminal",
  --   modifiers = { super, ctrl },
  --   key = "Return",
  --   on_press = function()
  --     awful.spawn.with_shell("$TERMINAL --class centered")
  --   end,
  -- },
  -- {
  --   description = "App launcher",
  --   modifiers = { super },
  --   key = "e",
  --   on_press = function()
  --     awful.spawn("rofi -show drun")
  --   end,
  -- },
  -- {
  --   description = "Select window to focus",
  --   modifiers = { super },
  --   key = "r",
  --   on_press = function()
  --     awful.spawn("rofi -show window")
  --   end,
  -- },
  -- {
  --   description = "Run script",
  --   modifiers = { super },
  --   key = "d",
  --   on_press = function()
  --     awful.spawn.with_shell("run_script")
  --   end,
  -- },
  -- {
  --   description = "Open tmux workspace",
  --   modifiers = { super },
  --   key = "x",
  --   on_press = function()
  --     awful.spawn.with_shell("sessions")
  --   end,
  -- },
  -- {
  --   description = "bookmark selector",
  --   modifiers = { super },
  --   key = "b",
  --   on_press = function()
  --     awful.spawn.with_shell("bookmarks $XDG_NC_DIR/Documents/bookmarks.txt")
  --   end,
  -- },
  -- {
  --   description = "Calculator",
  --   modifiers = { super },
  --   key = "c",
  --   on_press = function()
  --     awful.spawn.with_shell("rofi -show calc")
  --   end,
  -- },
  -- {
  --   description = "Power Menu",
  --   modifiers = { super, shift },
  --   key = "e",
  --   on_press = function()
  --     awful.spawn.with_shell("$XDG_BIN_DIR/rofi/power")
  --   end,
  -- },
  -- {
  --   description = "Log Out Screen",
  --   modifiers = { super, "Shift" },
  --   key = "d",
  --   on_press = function()
  --     exit_screen_show()
  --   end,
  -- },
  -- {
  --   description = "Open clipboard menu",
  --   modifiers = { super, ctrl },
  --   key = "c",
  --   on_press = function()
  --     awful.spawn.with_shell("CM_LAUNCHER=rofi clipmenu")
  --   end,
  -- },

  -- {
  --   description = "Make a screenshot",
  --   modifiers = { super },
  --   key = "p",
  --   on_press = function()
  --     awful.spawn.with_shell("flameshot gui")
  --   end,
  -- },
  -- {
  --   description = "Make a screenshot",
  --   modifiers = {},
  --   key = "Print",
  --   on_press = function()
  --     awful.spawn.with_shell("flameshot gui")
  --   end,
  -- },

  -- {
  --   description = "Open dotfiles",
  --   modifiers = { super, shift },
  --   key = "c",
  --   on_press = function()
  --     awful.spawn.with_shell(
  --       "$TERMINAL --working-directory $XDG_DOTFILES_DIR -e $SHELL -c 'nvim ; $SHELL'"
  --     )
  --   end,
  -- },
  -- {
  --   description = "Open notes",
  --   modifiers = { super, shift },
  --   key = "n",
  --   on_press = function()
  --     awful.spawn.with_shell(
  --       "$TERMINAL --working-directory $XDG_NC_DIR/Vault -e $SHELL -c 'nvim ; $SHELL'"
  --     )
  --   end,
  -- },
}

return gen_keys(keys, { group = group_name })
