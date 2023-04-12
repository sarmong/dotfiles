local naughty = require("naughty")

function _G.dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

function _G.log(title, text)
  naughty.notification({
    title = "log: " .. tostring(title),
    message = tostring(text),
  })
end

function _G.log_to_file(text)
  local file = io.open("~/awesome.log", "a")
  io.output(file)
  io.write("[" .. os.date() .. "] " .. text .. "\n")
  io.close(file)
end
