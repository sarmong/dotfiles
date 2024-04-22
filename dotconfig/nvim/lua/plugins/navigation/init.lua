return {
  {
    "stevearc/aerial.nvim",
    config = function()
      req("aerial").setup({})
      mapl({
        a = {
          t = { req("aerial").toggle, "code tree" },
        },
      })
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    version = "2.*",
    opts = {
      autoselect_one = true,
      include_current_win = true,
      highlights = {
        statusline = {
          focused = {
            bg = "#076678",
          },
          unfocused = {
            bg = "#076678",
          },
        },
        winbar = {
          focused = { bg = "#076678" },
          unfocused = {
            bg = "#076678",
          },
        },
      },
      filter_rules = {
        bo = {
          filetype = {
            "NvimTree",
            "neo-tree",
            "neo-tree-popup",
            "notify",
            "qf",
            "scratch",
          },
          buftype = { "terminal", "quickfix" },
        },
      },
    },
    config = function(_, opts)
      req("window-picker").setup(opts)

      function PickWindow(file)
        local picked = req("window-picker").pick_window()
        if not picked then
          return
        end
        a.nvim_set_current_win(picked)
        cmd("e " .. file)
      end

      command("Pick", function(e)
        PickWindow(e.fargs[1])
      end, { nargs = "?", complete = "file" })
    end,
  },
  {
    "chentoast/marks.nvim",
    opts = {
      sign_priority = { lower = 5, upper = 5, builtin = 5, bookmark = 4 }, -- lower priority than gitsigns
      default_mappings = true,
      mappings = {
        preview = "m;",
        next = "m]",
        prev = "m[",
        delete = "dm",
        delete_line = "dm-",
        delete_buffer = "dm<space>",
        annotate = "m:",
        toggle = false,
        set_next = false,
        -- press m0 to annotate
      },
      bookmark_0 = {
        sign = "⚑",
        annotate = true,
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      mapl({
        m = {
          a = {
            function()
              print(
                "Added "
                  .. string.gsub(
                    vim.api.nvim_buf_get_name(0),
                    vim.loop.cwd(),
                    ""
                  )
                  .. " to the harpoon"
              )
              req("harpoon.mark").add_file()
            end,
            "add mark",
          },
          s = { req("harpoon.ui").toggle_quick_menu, "show marks" },
          n = { req("harpoon.ui").nav_next, "next mark" },
          p = { req("harpoon.ui").nav_prev, "prev mark" },
        },
      })
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    version = ">=1.0.0",
    config = function()
      local ss = req("smart-splits")
      ss.setup({
        at_edge = "stop",
      })

      -- Note: keep these maps in sync with tmux.conf send-keys

      map("n", "<C-h>", ss.move_cursor_left, "move to left window")
      map("n", "<C-j>", ss.move_cursor_down, "move to bottom window")
      map("n", "<C-k>", ss.move_cursor_up, "move to top window")
      map("n", "<C-l>", ss.move_cursor_right, "move to right window")
      map("n", "<C-\\>", ss.move_cursor_previous, "move to prev window")

      -- these keymaps will also accept a range,
      -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
      map("n", "<C-Left>", ss.resize_left, "resize window left")
      map("n", "<C-Down>", ss.resize_down, "resize window down")
      map("n", "<C-Up>", ss.resize_up, "resize window up")
      map("n", "<C-Right>", ss.resize_right, "resize window right")

      map("n", "<leader><leader>h", ss.swap_buf_left, "swap buffer left")
      map("n", "<leader><leader>j", ss.swap_buf_down, "swap buffer down")
      map("n", "<leader><leader>k", ss.swap_buf_up, "swap buffer up")
      map("n", "<leader><leader>l", ss.swap_buf_right, "swap buffer right")
    end,
  },
}
