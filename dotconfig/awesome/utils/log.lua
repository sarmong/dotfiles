local naughty = require("naughty")

function _G.dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. tostring(k) .. '"'
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
  local file = io.open(os.getenv("HOME") .. "/awesome.log", "a")
  if not file then
    return
  end
  io.output(file)
  io.write("[" .. os.date() .. "] " .. dump(text) .. "\n")
  io.close(file)
end
