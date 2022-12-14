local awful = require("awful")

local global = require("keys.global")
local app_keys = require("keys.apps")
local media_keys = require("keys.media")
local tag_keys = require("keys.tag")

local client_local_keys = require("keys.client-keys").local_keys
local client_global_keys = require("keys.client-keys").global_keys
local mouse_bindings = require("keys.mouse")

awful.keyboard.append_global_keybindings(global)
awful.keyboard.append_global_keybindings(app_keys)
awful.keyboard.append_global_keybindings(media_keys)
awful.keyboard.append_global_keybindings(tag_keys)

awful.mouse.append_client_mousebindings(mouse_bindings)
awful.keyboard.append_client_keybindings(client_local_keys)
awful.keyboard.append_global_keybindings(client_global_keys)
