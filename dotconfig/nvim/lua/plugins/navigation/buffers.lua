return {
  {
    "j-morano/buffer_manager.nvim",
    config = function()
      mapl({
        m = {
          b = {
            req("buffer_manager.ui").toggle_quick_menu,
            "show [b]uffers",
          },
        },
      })
    end,
  },
  -- bufdel
  {
    "ojroques/nvim-bufdel",
    opts = {
      -- @TODO open issue to open on the right
      next = "alternate",
    },
  },
  -- barbar
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    version = "^1.0.0",
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      icons = {
        buffer_index = true,
        filetype = { enabled = true },
      },
      exclude_ft = { "qf" },
    },
    config = function(_, opts)
      req("barbar").setup(opts)

      map("n", "<C-TAB>", cmd.bind("BufferNext"))
      map("n", "<C-S-TAB>", cmd.bind("BufferPrevious"))
      map("n", "<A-.>", cmd.bind("BufferMoveNext"))
      map("n", "<A-,>", cmd.bind("BufferMovePrevious"))
      map("n", "<A-p>", cmd.bind("BufferPin"))
      map("n", "<S-x>", cmd.bind("BufferDelete"))
      map("n", "<A-w>", ":w<CR>:BufferClose<CR>")
      for i = 1, 9 do
        map("n", "<A-" .. i .. ">", cmd.bind("BufferGoto " .. i))
      end

      mapl({
        b = {
          name = "buffer",
          n = { cmd.bind("BufferNext"), "next buffer" },
          p = { cmd.bind("BufferPrev"), "prev buffer" },
          c = {
            name = "close",
            c = { cmd.bind("BufferCloseAllButCurrent"), "all but current" },
            p = { cmd.bind("BufferCloseAllButPinned"), "all but pinned" },
            l = { cmd.bind("BufferCloseBuffersLeft"), "all to the left" },
            r = { cmd.bind("BufferCloseBuffersRight"), "all to the right" },
          },
          o = {
            name = "order",
            d = { cmd.bind("BufferOrderByDirectory"), "by directory" },
          },
        },
      })
    end,
  },
}
