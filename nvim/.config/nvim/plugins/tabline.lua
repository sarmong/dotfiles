local bufferline = require("bufferline")

bufferline.setup({
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = "ordinal", -- "none" | "ordinal" } "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string
    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"

    indicator_icon = "▎",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",

    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match("%.md") then
        return vim.fn.fnamemodify(buf.name, ":t:r")
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      if context.buffer:current() then
        return ""
      end
      local map = {
        error = " ",
        warning = " ",
      }
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = map[e] or " "
        s = s .. n .. sym
      end
      return s
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "qf" then
        return true
      end
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "spectre_panel",
        text = "Search and Replace",
        highlight = "Directory",
        text_align = "left",
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant", -- "slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  },
})

local fns = {
  next_buf = function()
    vim.cmd("bnext")
  end,
  prev_buf = function()
    vim.cmd("bnext")
  end,

  next_tab = function()
    vim.cmd("BufferLineCycleNext")
  end,
  prev_tab = function()
    vim.cmd("BufferLineCyclePrev")
  end,

  move_next = function()
    vim.cmd("BufferLineMoveNext")
  end,
  move_prev = function()
    vim.cmd("BufferLineMovePrev")
  end,

  pin = function()
    vim.cmd("BufferLineTogglePin")
  end,

  close = function()
    vim.cmd("BufDel")
  end,

  go_to = function(n)
    vim.cmd("BufferLineGoToBuffer " .. n)
  end,

  pick = function()
    vim.cmd("BufferLinePick")
  end,

  -- TODO add to the plugin
  close_all_but_current = function()
    for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
      if
        vim.api.nvim_buf_is_loaded(buf_id)
        and vim.api.nvim_buf_get_option(buf_id, "buflisted")
        and buf_id ~= vim.api.nvim_get_current_buf()
      then
        vim.cmd("BufDel " .. buf_id)
      end
    end
  end,

  -- close_all_but_pinned = function()
  --   vim.cmd("BufferLineGroupClose pinned")
  -- end,

  close_all_to_the_left = function()
    vim.cmd("BufferLineCloseBuffers")
  end,

  close_all_to_the_right = function()
    vim.cmd("BufferLineCloseRight")
  end,

  order_by_directory = function()
    vim.cmd("BufferLineSortByDirectory")
  end,
}

vim.keymap.set(
  "n",
  "<leader><TAB>",
  fns.next_tab,
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader><S-TAB>",
  fns.prev_tab,
  { noremap = true, silent = true }
)
-- vim.keymap.set("n", "<C-i>", "<C-i>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-,>", fns.move_prev, { noremap = true, silent = true })
vim.keymap.set("n", "<A-.>", fns.move_next, { noremap = true, silent = true })
vim.keymap.set("n", "<A-p>", fns.pin, { noremap = true, silent = true })

vim.keymap.set("n", "<S-x>", fns.close, { noremap = true, silent = true })

for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", function()
    fns.go_to(i)
  end, { noremap = true, silent = true })
end

vim.keymap.set("n", "<A-0>", fns.pick, { noremap = true, silent = true })

return fns
