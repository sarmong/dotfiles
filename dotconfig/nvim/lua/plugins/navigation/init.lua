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
}
