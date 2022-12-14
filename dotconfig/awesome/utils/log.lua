local naughty = require("naughty")

function _G.log(title, text)
  naughty.notify({
    title = "log: " .. tostring(title),
    text = tostring(text),
  })
end
