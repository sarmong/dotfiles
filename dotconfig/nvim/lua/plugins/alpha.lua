Plugin({
  source = "goolord/alpha-nvim",
  depends = { "nvim-tree/nvim-web-devicons" },
})

local startify_config = req("alpha.themes.startify")

local M = {}

M.get_config = function()
  local session_files = req("modules.sessions").list_session_files()

  local btns = {}

  for key, value in ipairs(session_files) do
    if key > 3 then
      break
    end
    btns[key] = startify_config.button(
      "r" .. key,
      "Restore session " .. value,
      "<cmd>lua req('modules.sessions').load_session('" .. value .. "')<CR>"
    )
  end

  btns[#btns + 1] = startify_config.button("e", "New file", "<cmd>ene <CR>")

  local top_buttons = {
    type = "group",
    val = btns,
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
        autocmd("DirChanged", {
          pattern = "*",
          group = "alpha_temp",
          callback = function()
            require("alpha").redraw()
            vim.cmd("AlphaRemap")
          end,
        })
      end,
    },
  }
  return config
end

req("alpha").setup(M.get_config())

map("n", "<leader>;", function()
  req("alpha").start(false, M.get_config())
end, { desc = "home screen" })
