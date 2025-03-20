local awful = require("awful")

local function find_alt_screen(screen_1)
  local alt_screen
  for s in screen do
    if s ~= screen_1 then
      alt_screen = s
      break
    end
  end
  return alt_screen or screen_1
end

local function move_clients(screen_from, screen_to)
  screen_from = screen_from or awful.screen.focused()
  screen_to = screen_to or find_alt_screen(screen_from)

  for _, tag in ipairs(screen_from.tags) do
    local new_screen_tag = screen_to.tags[tag.index]
    for _, client in ipairs(tag:clients()) do
      client:move_to_tag(new_screen_tag)
    end
  end
end

local function connect()
  screen.connect_signal("primary_changed", function(old_primary_screen)
    if screen.primary ~= old_primary_screen then
      require("gears.timer").delayed_call(function()
        move_clients(old_primary_screen, screen.primary)
      end)
    end
  end)
end

return {
  move_clients = move_clients,
  find_alt_screen = find_alt_screen,
  connect = connect,
}
