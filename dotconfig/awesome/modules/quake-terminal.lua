local lain = require("lain")

local quake = lain.util.quake({
  app = os.getenv("TERMINAL"),
  argname = "--class %s",
  followtag = true,
  width = 0.6,
  height = 0.4,
  horiz = "center",
  overlap = true,
  settings = function(c)
    c.sticky = true
  end,
})

return quake
