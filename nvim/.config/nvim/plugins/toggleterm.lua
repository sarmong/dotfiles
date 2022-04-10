local Terminal = require("toggleterm.terminal").Terminal

local function on_term_open(term)
  vim.cmd("startinsert!")
  vim.api.nvim_buf_set_keymap(
    term.bufnr,
    "t",
    "<esc><esc>",
    "<cmd>close<CR>",
    { noremap = true, silent = true }
  )
end

require("toggleterm").setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<F1>]],
  on_open = on_term_open,
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = "horizontal", -- vertical | horizontal | window | float
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "single", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    width = 120,
    height = 27,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

local function toggle_term(cmd, count, direction)
  local app_term = Terminal:new({
    cmd = cmd,
    direction = direction or "float",
    count = count or 33,
    on_open = on_term_open,
  })
  return function()
    app_term:toggle()
  end
end

return {
  toggle_hor = toggle_term(nil, 1, "horizontal"),
  toggle_vert = toggle_term(nil, 2, "vertical"),
  toggle_float = toggle_term(nil, 3),
  toggle_git = toggle_term("lazygit", 4),
  toggle_npm = toggle_term("lazynpm", 5),
  toggle_node = toggle_term("node", 6),
  toggle_ranger = toggle_term("lf", 7),
}
