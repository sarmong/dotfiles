local alpha = require("alpha")
local startify_config = require("alpha.themes.startify")

local top_buttons = {
  type = "group",
  val = {
    startify_config.button(
      "r",
      "Restore session",
      "<cmd>source ./Session.vim<CR>"
    ),
    startify_config.button("e", "New file", "<cmd>ene <CR>"),
  },
}

local config = {
  layout = {
    { type = "padding", val = 1 },
    startify_config.section.header,
    { type = "padding", val = 2 },
    top_buttons,
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
