local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

-- Naughty presets
naughty.config.padding = 20
naughty.config.spacing = 20

naughty.config.defaults.timeout = 20
naughty.config.defaults.screen = 1
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.font = "Roboto Regular 10"
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = 0
naughty.config.defaults.hover_timeout = nil
naughty.config.defaults.max_width = 500

local function get_new_notif(notif)
   -- stylua: ignore start
   local properties = {
     "message"  , "title"   , "timeout" , "hover_timeout"     ,
     "app_name" , "position", "ontop"   , "border_width"      ,
     "width"    , "font"    , "icon"    , "icon_size"         ,
     "fg"       , "bg"      , "height"  , "border_color"      ,
     "shape"    , "opacity" , "margin"  , "ignore_suspend"    ,
     "destroy"  , "preset"  , "callback", "actions"           ,
     "run"      , --[["id"  ,]] "ignore"  , "auto_reset_timeout",
     "urgency"  , "image"   , "images"  , "widget_template"   ,
     "max_width", "app_icon",
   }
  -- stylua: ignore end

  local new_notif = {}
  for _, prop in ipairs(properties) do
    new_notif[prop] = notif["get_" .. prop](notif)
  end

  return new_notif
end

local history = {}
local notif_to_replay_idx = 0
local replayed_notif_id
-- Opens a file in append mode

naughty.connect_signal("destroyed", function(n)
  -- log_to_file(
  --   "signal added: "
  --     .. tostring(n:get_id())
  --     .. " ;;; "
  --     .. tostring(replayed_notif_id)
  --     .. "\n\n"
  -- )
  -- if n:get_id() ~= replayed_notif_id then
  table.insert(history, n)
  -- notif_to_replay_idx = notif_to_replay_idx + 1
  -- end
end)

local function replay_last_notif()
  local notif = table.remove(history, #history)
  if notif then
    local new_notif = get_new_notif(notif)
    naughty.notification(new_notif)
  end

  local notif = history[#history - notif_to_replay_idx]
  if notif then
    local new_notif = get_new_notif(notif)
    local replayed_notif = naughty.notification(new_notif)
    replayed_notif_id = replayed_notif:get_id()
    -- log_to_file(
    --   "replay_last_notif#if replayed_notif_id: " .. replayed_notif_id .. "\n"
    -- )
    -- log_to_file(
    --   "replay_last_notif#if notif_to_replay_idx: "
    --     .. notif_to_replay_idx
    --     .. "\n\n"
    -- )
  end
end

return replay_last_notif
