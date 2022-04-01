local alpha = require("alpha")
local startify_config = require("alpha.themes.startify")

local config = {
  layout = {
    { type = "padding", val = 1 },
    startify_config.section.header,
    { type = "padding", val = 2 },
    startify_config.section.top_buttons,
    startify_config.section.mru_cwd,
    startify_config.section.mru,
    { type = "padding", val = 1 },
    startify_config.section.bottom_buttons,
    startify_config.section.footer,
  },
  opts = {
    margin = 3,
    redraw_on_resize = false,
    setup = function()
      vim.cmd([[
            autocmd alpha_temp DirChanged * lua require('alpha').redraw()
            ]])
    end,
  },
}

alpha.setup(config)

return {
  open_home_page = function()
    alpha.start(false)
  end,
}
