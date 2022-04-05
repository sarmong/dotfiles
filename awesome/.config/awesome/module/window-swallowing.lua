local awful = require("awful")
local naughty = require("naughty")

local function is_terminal(c)
  return (c.class and c.class:match("Alacritty")) and true or false
end

local function copy_size(c, parent_client)
  if not c or not parent_client then
    return
  end
  if not c.valid or not parent_client.valid then
    return
  end
  c.x = parent_client.x
  c.y = parent_client.y
  c.width = parent_client.width
  c.height = parent_client.height
end

local function check_resize_client(c)
  naughty.notify({ title = c.class })
  if c.child_resize then
    copy_size(c.child_resize, c)
  end
end

client.connect_signal("property::size", check_resize_client)
client.connect_signal("property::position", check_resize_client)
client.connect_signal("manage", function(c)
  if is_terminal(c) then
    return
  end
  local parent_client = awful.client.focus.history.get(c.screen, 1)
  if parent_client and is_terminal(parent_client) then
    parent_client.child_resize = c

    parent_client.minimized = true
    -- c.floating = true
    c:connect_signal("unmanage", function()
      parent_client.minimized = false
    end)

    copy_size(c, parent_client)
  end
end)
