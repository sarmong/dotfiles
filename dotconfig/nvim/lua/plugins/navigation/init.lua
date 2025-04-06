Plugin("stevearc/aerial.nvim")
req("aerial").setup({})
mapl({
  a = {
    t = { req("aerial").toggle, "code tree" },
  },
})

Plugin("s1n7ax/nvim-window-picker")
req("window-picker").setup({
  picker_config = {
    handle_mouse_click = true,
  },
  highlights = {
    statusline = {
      focused = { bg = "#076678" },
      unfocused = { bg = "#076678" },
    },
    winbar = {
      focused = { bg = "#076678" },
      unfocused = { bg = "#076678" },
    },
  },

  filter_func = function(window_ids, filter_rules)
    return vim
      .iter(window_ids)
      :filter(function(winnr)
        local winfixbuf = a.nvim_get_option_value("winfixbuf", { win = winnr })
        local bufnr = a.nvim_win_get_buf(winnr)

        if winfixbuf then
          return false
        end

        local filetype = a.nvim_get_option_value("filetype", { buf = bufnr })
        local buftype = a.nvim_get_option_value("buftype", { buf = bufnr })

        if filetype == "alpha" then
          return true
        end

        local matches_ft = vim.tbl_contains(filter_rules.bo.filetype, filetype)
        local matches_bt = vim.tbl_contains(filter_rules.bo.buftype, buftype)

        return not matches_ft and not matches_bt
      end)
      :totable()
  end,

  filter_rules = {
    autoselect_one = true,
    include_current_win = true,
    bo = {
      filetype = {
        "TelescopePrompt",
        "TelescopeResults",
        "NvimTree",
        "neo-tree",
        "neo-tree-popup",
        "notify",
        "qf",
        "scratch",
        "fidget",
      },
      buftype = {
        "terminal",
        "quickfix",
        "nofile",
      },
      -- buflisted = { false },
    },
    wo = {
      winfixbuf = { true },
    },
  },
})

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

Plugin("chentoast/marks.nvim")
req("marks").setup({
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
})

-- Plugin("ThePrimeagen/harpoon")
Plugin("cbochs/grapple.nvim")

vim.keymap.set("n", "<leader>ma", require("grapple").toggle)
vim.keymap.set("n", "<leader>mA", require("grapple").toggle_tags)
mapl({
  m = {
    a = {
      function()
        print(
          "Added "
            .. string.gsub(vim.api.nvim_buf_get_name(0), vim.uv.cwd(), "")
            .. " to the grapple"
        )
        req("grapple").tag()
      end,
      "add mark",
    },
    s = { req("grapple").toggle_tags, "show marks" },
    n = {
      function()
        req("grapple").cycle_tags("next")
      end,
      "next mark",
    },
    p = {
      function()
        req("grapple").cycle_tags("prev")
      end,
      "prev mark",
    },
  },
})

Plugin("mrjones2014/smart-splits.nvim")
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
