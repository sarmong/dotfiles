local alpha = req("alpha")
local startify_config = req("alpha.themes.startify")

local session_file = "./Session.vim"

local function file_exists(path)
  local _, error = vim.loop.fs_stat(path)
  return error == nil
end

local top_buttons = {
  type = "group",
  val = {
    file_exists(session_file) and startify_config.button(
      "r",
      "Restore previous session",
      "<cmd>source " .. session_file .. "<CR>"
    ) or nil,
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
            autocmd alpha_temp DirChanged * lua req('alpha').redraw()
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