local lain = require("lain")

local dropdown = lain.util.quake({
  app = os.getenv("TERMINAL"),
  name = "Dropdown",
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

local scratch = lain.util.quake({
  app = os.getenv("TERMINAL"),
  name = "Scratch",
  argname = "--class %s",
  extra = string.format(
    "--working-directory %s -e %s -c 'nvim scratch.txt ; %s'",
    os.getenv("XDG_NC_DIR"),
    os.getenv("SHELL"),
    os.getenv("SHELL")
  ),
  followtag = true,
  width = 0.6,
  height = 0.4,
  horiz = "center",
  overlap = true,
  settings = function(c)
    c.sticky = true
  end,
})

return { dropdown = dropdown, scratch = scratch }
