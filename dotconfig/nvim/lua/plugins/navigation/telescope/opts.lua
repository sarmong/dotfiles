local actions = lreq("telescope.actions")
local sorters = lreq("telescope.sorters")
local previewers = lreq("telescope.previewers")
local utils = lreq("plugins.navigation.telescope.utils")

local defaults = {
  preview = {
    timeout = 1000,
  },
  cache_picker = {
    num_pickers = 20,
  },
  history = {
    path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
    limit = 100,
  },
  path_display = function(_, path)
    local dirs = vim.split(path, "/")
    local filename = table.remove(dirs, #dirs)

    local tail = table.concat(dirs, "/")

    tail = string.gsub(path, "^packages", "p")
    -- Prevents a toplevel filename to have a trailing whitespace
    local transformed_path = vim.trim(filename .. " " .. tail)

    local path_style = {
      { { #filename, #transformed_path }, "TelescopeResultsComment" },
    }

    return transformed_path, path_style
  end,
  sorting_strategy = "ascending",
  selection_strategy = "reset",
  vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
  },
  prompt_prefix = " ",
  selection_caret = " ",
  entry_prefix = "  ",
  initial_mode = "insert",
  layout_config = {
    prompt_position = "top",
  },
  layout_strategy = "flex",
  layout_defaults = {
    horizontal = { mirror = false },
    vertical = { mirror = false },
  },
  file_sorter = sorters.get_fuzzy_file,
  file_ignore_patterns = vim.tbl_flatten({
    "node_modules",
    "%.git",
    "yarn.lock",
    "package-lock.json",
    "%.yarn",
    "!%.config",
    "!%.local",
    Pref.search.exclude,
  }),
  generic_sorter = sorters.get_generic_fuzzy_sorter,
  shorten_path = true,
  winblend = 0,
  width = 0.75,
  preview_cutoff = 20,
  results_height = 1,
  results_width = 0.8,
  border = {},
  borderchars = {
    "─",
    "│",
    "─",
    "│",
    "╭",
    "╮",
    "╯",
    "╰",
  },
  color_devicons = true,
  set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  file_previewer = previewers.vim_buffer_cat.new,
  grep_previewer = previewers.vim_buffer_vimgrep.new,
  qflist_previewer = previewers.vim_buffer_qflist.new,

  -- Developer configurations: Not meant for general override
  buffer_previewer_maker = previewers.buffer_previewer_maker,
  mappings = {
    -- To disable a keymap, put [map] = false
    i = {
      ["<C-c>"] = false,
      -- ["Q"] = actions.close,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<C-h>"] = actions.select_horizontal,
      ["<C-Down>"] = actions.cycle_history_next,
      ["<C-Up>"] = actions.cycle_history_prev,
      ["<CR>"] = actions.select_default + actions.center,
      ["<C-Space>"] = actions.to_fuzzy_refine,
    },
    n = {
      ["<Esc>"] = false,
      ["Q"] = actions.close,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<C-h>"] = actions.select_horizontal,
      ["<CR>"] = actions.select_default + actions.center,
      ["<C-Space>"] = actions.to_fuzzy_refine,
    },
  },
}
local pickers = {
  buffers = {
    mappings = {
      n = {
        ["<CR>"] = actions.select_default,
        ["<C-CR>"] = actions.select_drop,
        ["<C-y>"] = actions.delete_buffer,
      },
      i = {
        ["<CR>"] = actions.select_default,
        ["<C-CR>"] = actions.select_drop,
        ["<C-y>"] = actions.delete_buffer,
      },
    },
    -- initial_mode = "normal",
  },
  grep_string = {
    initial_mode = "normal",
    mappings = {
      n = {
        ["<CR>"] = utils.pick_window_and_edit,
        ["<C-CR>"] = utils.multi_select,
      },
      i = {
        ["<CR>"] = utils.pick_window_and_edit,
        ["<C-CR>"] = utils.multi_select,
      },
    },
  },
  live_grep = {
    mappings = {
      n = {
        ["<CR>"] = utils.pick_window_and_edit,
        ["<C-CR>"] = utils.multi_select,
      },
      i = {
        ["<CR>"] = utils.pick_window_and_edit,
        ["<C-CR>"] = utils.multi_select,
      },
    },
  },
  find_files = {
    mappings = {
      n = {
        ["<CR>"] = utils.pick_window_and_edit,
        ["<C-CR>"] = utils.multi_select,
      },
      i = {
        ["<CR>"] = utils.pick_window_and_edit,
        ["<C-CR>"] = utils.multi_select,
      },
    },
  },
}

return {
  get = function()
    return {
      defaults = defaults,
      pickers = pickers,
    }
  end,
}
