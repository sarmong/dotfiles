local get_visual_selection = req("utils.get-visual-selection")
local root_dir = req("modules.root-dir")

local fns = {
  oldfiles = function()
    req("telescope.builtin").oldfiles({
      preview = { hide_on_startup = true },
      initial_mode = "normal",
      layout_config = { width = 0.5, height = 0.5 },
    })
  end,

  find_files = function(options)
    if vim.bo.filetype ~= "NvimTree" then
      req("telescope.builtin").find_files(
        vim.tbl_extend(
          "force",
          { hidden = true, cwd = root_dir.get_subpackage_root() },
          options or {}
        )
      )
    else
      -- Search inside the focused dir in nvim-tree
      local tree = req("nvim-tree.lib")
      local node = tree.get_node_at_cursor()
      if node then
        req("telescope.builtin").find_files({
          search_dirs = {
            not node.open and node.parent.absolute_path or node.absolute_path,
          },
          hidden = true,
        })
      end
    end
  end,

  text = function(options)
    if vim.bo.filetype ~= "NvimTree" then
      req("telescope").extensions.live_grep_args.live_grep_args(
        vim.tbl_extend(
          "force",
          { cwd = root_dir.get_subpackage_root() },
          options or {}
        )
      )
    else
      local tree = req("nvim-tree.lib")
      local node = tree.get_node_at_cursor()
      if node then
        req("telescope").extensions.live_grep_args.live_grep_args({
          search_dirs = {
            not node.open and node.parent.absolute_path or node.absolute_path,
          },
        })
      end
    end
  end,

  text_in_open_buffers = function()
    req("telescope.builtin").live_grep({ grep_open_files = true })
  end,
}

Plugin({
  source = "nvim-telescope/telescope.nvim",
  depends = {
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-project.nvim",
    {
      source = "nvim-telescope/telescope-fzf-native.nvim",
      hooks = {
        post_install = function(spec)
          vim.fn.system(
            "cd "
              .. spec.path
              .. " && cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
          )
        end,
      },
    },
    "nvim-telescope/telescope-live-grep-args.nvim",
    {
      source = "nvim-telescope/telescope-smart-history.nvim",
      -- Need libsqlite3-dev on debian
      depends = { "kkharji/sqlite.lua" },
    },
    "polirritmico/telescope-lazy-plugins.nvim",
    "sarmong/neoconf.nvim",
  },
})

local actions = req("telescope.actions")
local action_set = req("telescope.actions.set")
local sorters = req("telescope.sorters")
local previewers = req("telescope.previewers")
local lga_actions = req("telescope-live-grep-args.actions")

local opts = {
  defaults = {
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
      vim.tbl_keys(req("neoconf").get("vscode.search.exclude") or {}),
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
        ["Q"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-h>"] = actions.select_horizontal,
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
        ["<CR>"] = actions.select_default + actions.center,
        ["<C-CR>"] = function(prompt_bufnr)
          action_set.edit(prompt_bufnr, "Pick")
        end,
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
        ["<C-CR>"] = function(prompt_bufnr)
          action_set.edit(prompt_bufnr, "Pick")
        end,
        ["<C-Space>"] = actions.to_fuzzy_refine,
      },
    },
  },
  pickers = {
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
      mappings = {
        i = {
          ["<C-o>"] = lga_actions.quote_prompt({
            postfix = ' --iglob "**/',
          }),
        },
      },
      path_display = {
        filename_first = {
          reverse_directories = false,
        },
      },
    },
  },
}

local telescope = req("telescope")

telescope.setup(opts)

telescope.load_extension("media_files")
telescope.load_extension("project")
telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
-- telescope.load_extension("smart_history")
telescope.load_extension("lazy_plugins")

map("n", "<C-p>", fns.oldfiles, "oldfiles")

map("n", "<leader>f", fns.find_files, "find files")

mapl({
  s = {
    b = { ":Telescope buffers<cr>", "buffers" },
    B = { fns.text_in_open_buffers, "text in open [B]uffers" },
    c = { ":Telescope command_history<cr>", "history" },
    d = {
      ":Telescope diagnostics bufnr=0<cr>",
      "document_diagnostics",
    },
    D = {
      ":Telescope diagnostics<cr>",
      "workspace_diagnostics",
    },
    f = { fns.find_files, "files" },
    F = {
      function()
        req("telescope.builtin").find_files({
          cwd = root_dir.get_project_root(),
        })
      end,
      "files in root",
    },
    g = { ":Telescope git_status<cr>", "git status" },
    h = { ":Telescope help_tags<cr>", "vim help" },
    i = { ":Telescope media_files<cr>", "media files" },
    m = { ":Telescope marks<cr>", "marks" },
    M = { ":Telescope man_pages<cr>", "man_pages" },
    o = { ":Telescope vim_options<cr>", "vim_options" },
    t = { fns.text, "text" },
    T = {
      function()
        fns.text({
          cwd = root_dir.get_subpackage_root(),
        })
      end,
      "text in root",
    },
    w = { ":Telescope grep_string<cr>", "word" },
    R = { ":Telescope registers<cr>", "registers" },
    u = { ":Telescope colorscheme<cr>", "colorschemes" },
    p = { ":Telescope lazy_plugins<cr>", "projects" },
    s = {
      function()
        require("telescope.builtin").resume({ initial_mode = "normal" })
      end,
      "previous search",
    },
  },
})

map("v", "<leader>st", function()
  req("telescope").extensions.live_grep_args.live_grep_args({
    default_text = get_visual_selection(),
  })
end, "selected text")
