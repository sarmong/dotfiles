-- https://github.com/mpv-player/mpv/issues/8655#issuecomment-2868856223
local function init()
  local opts = mp.get_property_native("options/script-opts")
  if opts and opts["http-ytproxy"] == "no" then
    return
  end

  local url = mp.get_property("stream-open-filename")
  print("url -> " .. url)

  -- check for youtube playlist link
  local pattern = "https://www%.youtube%.com/playlist%?list%="

  -- check for youtube link
  if
    url:find("^https:") == nil
    or (url:find("youtu") == nil and url:find("yewtu") == nil)
    or string.match(url, pattern)
  then
    return
  end

  local proxy = mp.get_property("http-proxy")
  local ytdl_raw_options = mp.get_property("ytdl-raw-options")
  if
    (proxy and proxy ~= "" and proxy ~= "http://127.0.0.1:12081")
    or (ytdl_raw_options and ytdl_raw_options:match("proxy=([^ ]+)"))
  then
    return
  end

  print("starting mitmproxy...")
  math.randomseed(os.time())
  local proxyport = math.random(12000, 13000)

  -- launch mitmproxy
  local args = {
    -- version in apt is too old, install with pipx
    "/usr/local/bin/mitmdump",
    "-s",
    mp.get_script_directory() .. "/mitmplugin.py",
    "--set",
    "web_open_browser=false",
    "--set",
    "listen_port=" .. proxyport,
    "--mode",
    "regular@" .. proxyport,
  }

  mp.command_native_async({
    name = "subprocess",
    capture_stdout = true,
    capture_stderr = true,
    playback_only = true,
    args = args,
  })

  mp.set_property(
    "file-local-options/http-proxy",
    "http://127.0.0.1:" .. proxyport
  )
  mp.set_property("file-local-options/tls-verify", "no")
  -- this is not really needed
end

mp.register_event("start-file", init)
