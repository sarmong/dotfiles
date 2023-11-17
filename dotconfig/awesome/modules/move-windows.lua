local awful = require("awful")
local gears = require("gears")

local function move_windows()
  log("screen", awful.screen.focused())
  -- log("screens", screen.instances())
  -- for s, x in pairs(screen.instances()) do
  --   print(s, x)
  --   -- gears.debug.dump(s, "scren")
  -- end
  --
  for _, c in ipairs(client.get(screen[2])) do
    local tag_idx = c.first_tag.index
    local new_tag = screen[1].tags[tag_idx]
    c:move_to_tag(new_tag)
    -- log(s.tags[1], dump(s.tags[1]:clients()))
    -- for x, y in pairs(s.tags[4]:clients()) do
    --   log(x, dump(y))
    -- end
  end
end

-- screen.connect_signal("removed", function(s)
--   -- s.all_clients
--   log_to_file("scren removed \n" .. dump(s.outputs))
-- end)
--
-- screen.connect_signal("added", function(s)
--   log_to_file("scren added \n" .. dump(s.outputs))
-- end)
--
-- screen.connect_signal("request::remove", function(s)
--   log_to_file("request remove \n" .. dump(s.outputs))
-- end)
-- screen.connect_signal("request::create", function(s)
--   log_to_file("request create \n" .. dump(s.outputs))
-- end)
--
-- screen.connect_signal("primary_changed", function(s)
--   log_to_file("primary_changed \n" .. dump(s.outputs))
-- end)

return move_windows
