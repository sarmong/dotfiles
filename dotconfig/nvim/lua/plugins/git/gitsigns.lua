return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = "│",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = "│",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "_",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "‾",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "~",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter_opts = {
        relative_time = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    },
    config = function(_, opts)
      local gitsigns = req("gitsigns")
      gitsigns.setup(opts)

      req("which-key").register({
        g = {
          name = "git",
          j = { gitsigns.next_hunk, "next hunk" },
          k = { gitsigns.prev_hunk, "prev hunk" },
          r = { gitsigns.reset_hunk, "reset hunk" },
          R = { gitsigns.reset_buffer, "reset buffer" },
          s = { gitsigns.stage_hunk, "stage hunk" },
          B = { gitsigns.stage_buffer, "stage buffer" },
          u = { gitsigns.undo_stage_hunk, "undo stage hunk" },
          w = { gitsigns.toggle_word_diff, "toggle word diff" },
          p = { gitsigns.preview_hunk, "preview hunk" },
          K = {
            function()
              gitsigns.blame_line({ full = true })
            end,
            "show blame in hover",
          },
        },
      }, { prefix = "<leader>" })
    end,
  },
}
