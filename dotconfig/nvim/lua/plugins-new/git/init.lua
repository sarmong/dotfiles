return {
  { "tpope/vim-fugitive" },
  {
    "f-person/git-blame.nvim",
    opts = { enabled = false },
    config = function(_, opts)
      req("gitblame").setup(opts)

      map("n", "<leader>gb", cmd.bind("GitBlameToggle"))
    end,
  },
  {
    "NeogitOrg/neogit",
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
  { "sindrets/diffview.nvim" },
  {
    "ruifm/gitlinker.nvim",
    opts = {
      opts = {
        -- adds current line nr in the url for normal mode
        add_current_line_on_normal_mode = false,
        -- print the url after performing the action
        print_url = true,
      },
      mappings = nil,
    },
    fns = {
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
    },
    config = function(spec, opts)
      local gl = req("gitlinker")
      gl.setup(opts)

      map("n", "<leader>go", spec.fns.open_repo, "open repo")
      map("n", "<leader>gO", spec.fns.open_line_url, "open line url")
      map("n", "<leader>gy", spec.fns.yank_repo, "yank repo")
      map("n", "<leader>gY", spec.fns.yank_repo, "yarnk line url")
    end,
  },
}
