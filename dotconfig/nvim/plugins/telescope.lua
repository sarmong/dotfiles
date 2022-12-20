local telescope = req("telescope")
local actions = req("telescope.actions")
local action_set = req("telescope.actions.set")
local sorters = req("telescope.sorters")
local previewers = req("telescope.previewers")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup({
  defaults = {
    preview = {
      timeout = 1000,
    },
    path_display = { "truncate" },
    sorting_strategy = "descending",
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
    prompt_position = "top",
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = { mirror = false },
      vertical = { mirror = false },
    },
    file_sorter = sorters.get_fuzzy_file,
    file_ignore_patterns = {
      "node_modules",
      "%.git",
      "yarn.lock",
      "package-lock.json",
      "%.yarn",
      "!%.config",
      "!%.local",
    },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 20,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    mappings = {
      -- To disable a keymap, put [map] = false
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc><esc>"] = actions.close,

        -- Otherwise, just set the mapping to the function that you want it to be.
        -- ["<C-i>"] = actions.select_horizontal,

        -- Add up multiple actions
        ["<CR>"] = actions.select_default + actions.center,

        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,

        ["<C-y>"] = actions.delete_buffer,

        ["<S-CR>"] = function(prompt_bufnr)
          action_set.edit(prompt_bufnr, "Pick")
        end,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-y>"] = actions.delete_buffer,
        ["<esc><esc>"] = actions.close,
        ["<S-CR>"] = function(prompt_bufnr)
          action_set.edit(prompt_bufnr, "Pick")
        end,
      },
    },
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    live_grep_args = {
      auto_quoting = true, -- If the prompt value does not begin with ', " or - the entire prompt is treated as a single argument
      default_mappings = {
        i = {
          ["<C-o>"] = lga_actions.quote_prompt({ postfix = ' --iglob "**/' }),
        },
      },
    },
  },
})

telescope.load_extension("media_files")
-- This is a separate plugin
telescope.load_extension("project")
-- This one's coming from project.nvim
telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
