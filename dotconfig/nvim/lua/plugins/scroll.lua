return {
  { "sarmong/vim-smoothie", event = "VeryLazy" },
  {
    "karb94/neoscroll.nvim",
    enabled = false,
    config = function()
      req("neoscroll").setup({
        -- easing_function = "quintic",
        mappings = {},
        hide_cursor = false,
      })

      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      -- Use the "sine" easing function
      t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "200", "circular" } }
      t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "200", "circular" } }
      -- Use the "circular" easing function
      t["<C-b>"] = {
        "scroll",
        { "-vim.api.nvim_win_get_height(0)", "true", "500", [['circular']] },
      }
      t["<C-f>"] = {
        "scroll",
        { "vim.api.nvim_win_get_height(0)", "true", "500", [['circular']] },
      }
      -- Pass "nil" to disable the easing animation (constant scrolling speed)
      -- When no easing function is provided the default easing function (in this case "quadratic") will be used
      t["zt"] = { "zt", { "100" } }
      t["zz"] = { "zz", { "100" } }
      t["zb"] = { "zb", { "100" } }

      require("neoscroll.config").set_mappings(t)
    end,
  },
}
