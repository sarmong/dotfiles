Plugin({
  source = "goolord/alpha-nvim",
  depends = { "nvim-tree/nvim-web-devicons" },
})

local startify_config = req("alpha.themes.startify")

local session_file = "./Session.vim"

local function file_exists(path)
  local _, error = vim.uv.fs_stat(path)
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
    {
      type = "group",
      val = { startify_config.button("Q", "Quit", "<cmd>q <CR>") },
    },
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

req("alpha").setup(config)

map("n", "<leader>;", req("alpha").start, { desc = "home screen" })
