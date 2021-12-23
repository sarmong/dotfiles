local alpha = require("alpha")

alpha.setup(require("alpha.themes.startify").opts)

return {
  open_home_page = function()
    alpha.start(false)
  end,
}
