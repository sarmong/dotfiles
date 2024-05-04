local fns = {
  open_repo = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    if current_mode == "v" then
      local text = req("utils.get-visual-selection")()

      local url = "https://github.com/" .. text
      vim.fn.system("xdg-open " .. url)
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
      local text = req("utils.get-visual-selection")()

      local url = "https://github.com/" .. text
      vim.fn.setreg("+", url)
    else
      req("gitlinker").get_repo_url({
        action_callback = req("gitlinker").actions.copy_to_clipboard,
      })
    end
  end,

  yank_line_url = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    req("gitlinker").get_buf_range_url(
      string.lower(current_mode),
      { action_callback = req("gitlinker").actions.copy_to_clipboard }
    )
  end,
}
return {
  { "tpope/vim-fugitive", event = "VeryLazy" },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = { enabled = false },
    config = function(_, opts)
      req("gitblame").setup(opts)

      map("n", "<leader>gb", cmd.bind("GitBlameToggle"))
    end,
  },
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    opts = {
      integrations = {
        diffview = true,
      },
      -- kind = "replace", -- temp fix for https://github.com/TimUntersberger/neogit/issues/389
    },
    config = function(_, opts)
      req("neogit").setup(opts)

      map("n", "<leader>gn", req("neogit").open, "neogit")
    end,
  },
  { "sindrets/diffview.nvim", event = "VeryLazy" },
  {
    "ruifm/gitlinker.nvim",
    event = "VeryLazy",
    opts = {
      opts = {
        -- adds current line nr in the url for normal mode
        add_current_line_on_normal_mode = false,
        -- print the url after performing the action
        print_url = true,
      },
      mappings = "<nop>",
    },
    config = function(spec, opts)
      local gl = req("gitlinker")
      gl.setup(opts)

      map({ "n", "v" }, "<leader>go", fns.open_repo, "open repo")
      map({ "n", "v" }, "<leader>gO", fns.open_line_url, "open line url")
      map({ "n", "v" }, "<leader>gy", fns.yank_repo, "yank repo")
      map({ "n", "v" }, "<leader>gY", fns.yank_line_url, "yarnk line url")
    end,
  },
}
