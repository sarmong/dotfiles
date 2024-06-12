local fns = {
  open_repo = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    if current_mode == "v" then
      local text = req("utils.get-visual-selection")()[1]

      local url = "https://github.com/" .. text
      vim.ui.open(url)
    else
      req("gitlinker").get_repo_url({
        action_callback = req("gitlinker").actions.open_in_browser,
      })
    end
  end,

  open_line_url = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    req("gitlinker").get_buf_range_url(
      string.lower(current_mode),
      { action_callback = req("gitlinker").actions.open_in_browser }
    )
  end,

  yank_repo = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    if current_mode == "v" then
      local text = req("utils.get-visual-selection")()[1]

      local url = "https://github.com/" .. text
      vim.fn.setreg("+", url)
    else
      req("gitlinker").get_repo_url({
        action_callback = function(url)
          vim.fn.setreg("+", url)
        end,
      })
    end
  end,

  yank_line_url = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    req("gitlinker").get_buf_range_url(string.lower(current_mode), {
      action_callback = function(url)
        vim.fn.setreg("+", url)
      end,
    })
  end,
}
Plugin("tpope/vim-fugitive")
Plugin("f-person/git-blame.nvim")
req("gitblame").setup({ enabled = false })

map("n", "<leader>gb", cmd.bind("GitBlameToggle"))

Plugin("NeogitOrg/neogit")
req("neogit").setup({
  integrations = {
    diffview = true,
  },
  -- kind = "replace", -- temp fix for https://github.com/TimUntersberger/neogit/issues/389
})

map("n", "<leader>gn", req("neogit").open, "neogit")
Plugin("sindrets/diffview.nvim")
Plugin("linrongbin16/gitlinker.nvim")

local gl = req("gitlinker")

gl.setup({
  opts = {
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = false,
    -- print the url after performing the action
    print_url = true,
    action_callback = function(url)
      vim.fn.setreg("+", url)
    end,
  },

  mappings = "<nop>",
})

map({ "n", "v" }, "<leader>go", fns.open_repo, "open repo")
map({ "n", "v" }, "<leader>gO", fns.open_line_url, "open line url")
map({ "n", "v" }, "<leader>gy", fns.yank_repo, "yank repo")
map({ "n", "v" }, "<leader>gY", fns.yank_line_url, "yarnk line url")
