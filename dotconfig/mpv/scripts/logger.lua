local utils = require("mp.utils")

local playlist_metadata = {}

local function set_metadata(url, id)
  if not url:match("^https://") then
    return
  end

  local args = {
    "yt-dlp",
    "--dump-single-json",
    url,
  }
  mp.command_native_async({
    name = "subprocess",
    args = args,
    playback_only = false,
    capture_stdout = true,
  }, function(success, res)
    local json, err = utils.parse_json(res.stdout)
    playlist_metadata[id] = json
  end)
end

local function save_recent()
  -- If playlist consist of local files - don't save
  if not playlist_metadata or #playlist_metadata < 1 then
    return
  end
  local datetime = os.date("%Y-%m-%dT%H:%M:%S")
  local HISTFILE = os.getenv("XDG_NC_DIR")
    .. "/mpv/recent/"
    .. datetime
    .. ".txt"
  local logfile, err = io.open(HISTFILE, "a+")
  if not logfile then
    msg.error("Could not write to histfile. Error: " .. (err or "unknown"))
  end

  for _, value in ipairs(playlist_metadata) do
    logfile:write(
      ("%s\n%s\n%s\n[%s]\n\n"):format(
        value.channel,
        value.title,
        value.original_url,
        value.duration_string
      )
    )
  end
  logfile:write("\n")
  logfile:close()
end

local function mpvhistory()
  local HISTFILE = os.getenv("XDG_NC_DIR") .. "/mpv/history.txt"

  local title = mp.get_property("media-title")
  local url = mp.get_property("path")
  local seconds = mp.get_property("duration")
  if not url:match("^https://") then
    url = mp.get_property_native("metadata").PURL
  end

  local duration = math.floor(seconds / 60) .. ":" .. math.floor(seconds % 60)
  local datetime = os.date("%d.%m.%Y %H:%M")

  local logfile, err = io.open(HISTFILE, "a+")
  if not logfile then
    msg.error("Could not write to histfile. Error: " .. (err or "unknown"))
  end
  -- @TODO add channel
  logfile:write(("%s [%s]\n%s\n%s\n\n"):format(title, duration, url, datetime))
  logfile:close()
end
mp.register_event("file-loaded", mpvhistory)

mp.observe_property("playlist", "native", function(_, value)
  for _, val in ipairs(value) do
    print("id : ", val.id)
    if not playlist_metadata[val.filename] then
      set_metadata(val.filename, val.id)
    end
  end
end)

mp.register_event("shutdown", save_recent)
