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
        vim.tbl_extend("force", { hidden = true }, options or {})
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

  text = function(args)
    if vim.bo.filetype ~= "NvimTree" then
      req("telescope").extensions.live_grep_args.live_grep_args(args)
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

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-live-grep-args.nvim",
      {
        "nvim-telescope/telescope-smart-history.nvim",
        -- Need libsqlite3-dev on debian
        dependencies = "kkharji/sqlite.lua",
      },
    },

    opts = function()
      local actions = req("telescope.actions")
      local action_set = req("telescope.actions.set")
      local sorters = req("telescope.sorters")
      local previewers = req("telescope.previewers")
      local lga_actions = req("telescope-live-grep-args.actions")

      return {
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
          path_display = { "truncate" },
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
              ["<esc><esc>"] = actions.close,
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
            },
            n = {
              ["<esc><esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-h>"] = actions.select_horizontal,
              ["<CR>"] = actions.select_default + actions.center,
              ["<C-CR>"] = function(prompt_bufnr)
                action_set.edit(prompt_bufnr, "Pick")
              end,
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
          },
        },
      }
    end,

    config = function(_, opts)
      local telescope = req("telescope")

      telescope.setup(opts)

      telescope.load_extension("media_files")
      -- This is a separate plugin
      telescope.load_extension("project")
      -- This one's coming from project.nvim
      telescope.load_extension("projects")
      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
      -- telescope.load_extension("smart_history")

      map("n", "<C-p>", fns.oldfiles, "oldfiles")

      map("n", "<leader>f", fns.find_files, "find files")

      mapl({
        s = {
          name = "search",
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
                cwd = vim.fs.dirname(
                  vim.fs.find(
                    { "package-lock.json", "yarn.lock", ".git" },
                    { upward = true, stop = vim.loop.os_homedir() }
                  )[1]
                ),
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
                search_dirs = {
                  fn.finddir(".git/..", fn.expand("%:p:h") .. ";"),
                },
              })
            end,
            "text in root",
          },
          w = { ":Telescope grep_string<cr>", "word" },
          R = { ":Telescope registers<cr>", "registers" },
          u = { ":Telescope colorscheme<cr>", "colorschemes" },
          p = { ":Telescope projects<cr>", "projects" },
          s = {
            function()
              require("telescope.builtin").resume({ initial_mode = "normal" })
            end,
            "previous search",
          },
        },
      })

      map(
        "v",
        "<leader>st",
        "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>",
        "selected text"
      )
    end,
  },
}